---
layout: archive
title: "Curriculum vitae"
permalink: /bio/
author_profile: true
redirect_from:
  - /resume
  - /cv
  - /overview
---

{% include base_path %}

## Education
<div class="education-list">
  <div class="education-entry">
    <p class="education-date">2023–present</p>
    <div><h3>Doctoral researcher in Mathematics</h3><p>University of Hamburg</p></div>
  </div>
  <div class="education-entry">
    <p class="education-date">2020–2023</p>
    <div><h3>M.Sc. Mathematical Physics</h3><p>University of Hamburg</p></div>
  </div>
  <div class="education-entry">
    <p class="education-date">2016–2020</p>
    <div><h3>B.Sc. Computing in Science with focus physics</h3><p>University of Hamburg</p></div>
  </div>
</div>

## Publications
<div class="publicationsbox">
{% include publication-list.html compact=true %}
</div>

{% include outreach.html %}

## Invited talks

{% assign automatic = site.talks | where_exp: 'entry', 'entry.order == nil' | sort: 'date' | reverse %}
{% assign manual = site.talks | where_exp: 'entry', 'entry.order != nil' | sort: 'order' | reverse %}
{% assign talks = automatic | concat: manual %}
<ul class="cvlist">
{% for entry in talks %}{% include event-entry.html item=entry compact=true %}{% endfor %}
</ul>

<p class="section-link"><a href="{{ '/talks/#attended-conferences' | relative_url }}">Attended conferences <span aria-hidden="true">→</span></a></p>

## Teaching

{% assign automatic = site.teaching | where_exp: 'entry', 'entry.order == nil' | sort: 'start_year' | reverse %}
{% assign manual = site.teaching | where_exp: 'entry', 'entry.order != nil' | sort: 'order' | reverse %}
{% assign teaching = automatic | concat: manual %}
<ul class="cvlist">
{% for entry in teaching %}{% include teaching-entry.html item=entry compact=true %}{% endfor %}
</ul>

## Computational project

[**Database of colored superpolynomials**](https://colored-kh.math.uni-hamburg.de)**.** I developed this interactive research database to accompany my work on colored Khovanov homology. The project includes the Python/Streamlit application as well as the preparation, organization, and presentation of the underlying mathematical data.
