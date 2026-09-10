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
* Doctoral researcher in Mathematics, University of Hamburg, 2023-present
* M.Sc. Mathematical Physics, University of Hamburg, 2020-2023
* B.Sc. Computing in Science with focus physics, University of Hamburg, 2016-2020

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
