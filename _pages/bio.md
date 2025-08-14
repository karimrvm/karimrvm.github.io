---
layout: archive
title: "Overview"
permalink: /bio/
author_profile: true
redirect_from:
  - /resume
  - /cv
  - /overview
---

{% include base_path %}

## Education
* Ph.D student in Mathematics, University of Hamburg, 2023-present
* M.Sc. Mathematical Physics, University of Hamburg, 2020-2023
* B.Sc. Computing in Science with focus physics, University of Hamburg, 2016-2020

## Publications
  <div class="publicationsbox">{% if site.publication_category %}
  {% for category in site.publication_category  %}
    {% assign title_shown = false %}
    {% for post in site.publications reversed %}
      {% if post.category != category[0] %}
        {% continue %}
      {% endif %}
      {% unless title_shown %}
        <h3 class = "archive__item-title">{{ category[1].title }}</h3>
        {% assign title_shown = true %}
      {% endunless %}
      <ul class="cvlist">
      {% include archive-single-cv.html %}
      </ul>
    {% endfor %}
  {% endfor %}
{% else %}
  {% for post in site.publications reversed %}
    {% include archive-single.html %}
  {% endfor %}
{% endif %}</div>
  
## Talks

  <ul class ="cvlist">{% for post in site.talks reversed %}
    {% include archive-single-talk-cv.html  %}
  {% endfor %}</ul>
  
## Teaching

  <ul class ="cvlist"> {% for post in site.teaching reversed %}
    {% include archive-single-cv.html %}
  {% endfor %}</ul>
  
## Outreach
* {:.cvlist_item} Main organizer of the Hamburg-based venue of the high school math competition [Náboj](https://math.naboj.org) in 2024 and 2025.

## Skills
* {:.cvlist_item} Programming: Java (basic), Python (proficient), C (basics of OpenMP and MPI)