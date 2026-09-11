#!/usr/bin/env ruby
# No external gems required. Run from any directory.
require 'yaml'
require 'date'
require 'uri'

root = File.expand_path('..', __dir__)
errors = []
count = 0
required = {
  '_publications' => %w[title status arxiv_date],
  '_teaching' => %w[title start_year],
  '_talks' => %w[title date],
  '_conferences' => %w[title start_date]
}
required.each do |folder, fields|
  orders = {}
  Dir.glob(File.join(root, folder, '*.md')).sort.each do |file|
    count += 1
    name = file.delete_prefix(root + '/')
    report = ->(message) { errors << "#{name}: #{message}" }
    begin
      source = File.read(file)
      match = source.match(/\A---\s*\n(.*?)\n---(?:\s*\n|\z)/m)
      raise 'Missing YAML front matter' unless match
      data = YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: false)
      raise 'Front matter must be a mapping' unless data.is_a?(Hash)
      fields.each { |key| report.call("Missing #{key}") if data[key].nil? || data[key].to_s.strip.empty? }
      if !data.key?('order') || data['order'].nil?
        # No manual rank: this entry is sorted by date above manually ranked entries.
      elsif !data['order'].is_a?(Integer)
        report.call('order must be an integer; larger values appear first')
      elsif orders.key?(data['order'])
        report.call("Duplicate order #{data['order']} (also in #{orders[data['order']]})")
      else
        orders[data['order']] = name
      end
      if folder == '_publications' && !%w[preprint accepted published].include?(data['status'])
        report.call('status must be preprint, accepted or published')
      end
      dates = {}
      %w[date start_date end_date arxiv_date published_date].each do |key|
        next unless data.key?(key)
        value = data[key].to_s
        begin
          raise ArgumentError unless value.match?(/\A\d{4}-\d{2}-\d{2}\z/)
          dates[key] = Date.iso8601(value)
        rescue ArgumentError
          report.call("#{key} must be a real date in YYYY-MM-DD format")
        end
      end
      if dates['start_date'] && dates['end_date'] && dates['end_date'] < dates['start_date']
        report.call('end_date precedes start_date')
      end
      if folder == '_teaching'
        %w[start_year end_year].each do |key|
          next if key == 'end_year' && data[key].nil?
          report.call("#{key} must be a four-digit year") unless data[key].is_a?(Integer) && (1000..9999).cover?(data[key])
        end
        if data['start_year'].is_a?(Integer) && data['end_year'].is_a?(Integer) && data['end_year'] < data['start_year']
          report.call('end_year precedes start_year')
        end
      end
      if data.key?('remote') && ![true, false].include?(data['remote'])
        report.call('remote must be true or false, without quotes')
      end
      %w[arxiv_url paper_url slides_url bibtex_url database_url link].each do |key|
        next unless data.key?(key)
        value = data[key].to_s
        begin
          uri = URI.parse(value)
          local = value.start_with?('/') && !value.start_with?('//')
          external = %w[http https].include?(uri.scheme) && uri.host && !uri.host.empty?
          report.call("#{key} must be an HTTP(S) URL or a site path starting with /") unless local || external
        rescue URI::InvalidURIError
          report.call("#{key} is not a valid URL")
        end
      end
      if data.key?('doi') && !data['doi'].to_s.match?(/\A10\.\d{4,9}\/\S+\z/)
        report.call('doi must contain the identifier only, e.g. 10.1234/example')
      end
      %w[category arxivdate arxivurl excerpt time details description startdate enddate collection].each do |key|
        report.call("Legacy field #{key}; see CONTENT_GUIDE.md") if data.key?(key)
      end
    rescue StandardError => e
      report.call(e.message)
    end
  end
end
if errors.empty?
  puts "OK: #{count} content files checked."
else
  warn errors.join("\n")
  exit 1
end
