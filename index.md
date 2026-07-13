---
layout: home
---

I don't like a lot of the default behavior in MacOS. This list contains the fixes I've found to make MacOS less annoying.

> Disclaimer: This is NOT a definitive list and will grow & shrink as I see fit. If you have any comments or concerns, keep them to your self.

{% for group in site.data.tools -%}
## {{ group.category }}

{{ group.description }}

{% for item in group.items -%}
- {{ item.emoji }} **{{ item.name }}** — [{{ item.link_text }}]({{ item.link }}){% if item.repo %} {% include stars.html repo=item.repo %}{% endif %}
  - {{ item.desc }}
{% endfor %}
{% endfor -%}
