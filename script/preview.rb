#!/usr/bin/env ruby
# frozen_string_literal: true

# Renders index.md (Liquid + _data/tools.yml + _includes/stars.html) into a
# standalone HTML file for quick local preview, WITHOUT a full Jekyll build.
#
# Usage:
#   bundle install                 # once, to fetch liquid + kramdown
#   bundle exec ruby script/preview.rb
#
# Output: _preview/index.html (open it in a browser; toggle your OS light/dark
# mode to verify the adaptive star badges).

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require "liquid"
require "kramdown"
require "yaml"
require "fileutils"

ROOT = File.expand_path("..", __dir__)
Dir.chdir(ROOT)

# Emulate Jekyll's include tag: `{% include file.html key=value %}` exposes the
# params as `{{ include.key }}` inside the included file. Values that look like a
# quoted string are used literally; otherwise they're resolved against the context
# (e.g. `repo=item.repo`).
class JekyllInclude < Liquid::Tag
  def initialize(tag_name, markup, tokens)
    super
    parts = markup.strip.split(/\s+/)
    @file = parts.shift
    @params = {}
    parts.each do |pair|
      key, value = pair.split("=", 2)
      @params[key] = value
    end
  end

  def render(context)
    content = File.read(File.join("_includes", @file), encoding: "UTF-8")
    resolved = {}
    @params.each do |key, value|
      resolved[key] = value =~ /\A["'].*["']\z/ ? value[1..-2] : context[value]
    end
    context.stack do
      context["include"] = resolved
      Liquid::Template.parse(content).render(context)
    end
  end
end
Liquid::Template.register_tag("include", JekyllInclude)

# Minimal stub for jekyll-seo-tag's `{% seo %}`. We don't need its full output for
# a styling preview -- just a <title> so the layout renders as it does in Jekyll.
class SeoStub < Liquid::Tag
  def render(context)
    site = context["site"] || {}
    title = site["title"]
    description = site["description"]
    out = +%(<title>#{title}</title>\n)
    out << %(<meta name="description" content="#{description}">\n) if description
    out
  end
end
Liquid::Template.register_tag("seo", SeoStub)

def strip_front_matter(source)
  source.sub(/\A---\s*\n.*?\n---\s*\n/m, "")
end

config = YAML.load_file("_config.yml")
tools = YAML.load_file("_data/tools.yml")

# `site` mirrors the subset of Jekyll's site object that our templates reference.
site = {
  "lang" => config["lang"],
  "title" => config["title"],
  "description" => config["description"],
  "data" => { "tools" => tools },
}

# 1. Render index.md's body (Liquid + data + includes), then Markdown -> HTML.
body = strip_front_matter(File.read("index.md", encoding: "UTF-8"))
markdown = Liquid::Template.parse(body).render("site" => site)
content_html = Kramdown::Document.new(markdown).to_html
content_html += <<~NOTE
  \n<hr>
  <p><small><em>Local preview — same Pico CSS and layout as the deployed site. Toggle your OS light/dark mode to test the star badges.</em></small></p>
NOTE

# 2. Render the REAL layout so the preview stays in sync with _layouts/default.html.
layout = strip_front_matter(File.read("_layouts/default.html", encoding: "UTF-8"))
page = Liquid::Template.parse(layout).render("site" => site, "content" => content_html)

FileUtils.mkdir_p("_preview")
output = File.join("_preview", "index.html")
File.write(output, page)
puts "Wrote #{output}"
