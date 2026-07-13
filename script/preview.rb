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

def strip_front_matter(source)
  source.sub(/\A---\s*\n.*?\n---\s*\n/m, "")
end

config = YAML.load_file("_config.yml")
body = strip_front_matter(File.read("index.md", encoding: "UTF-8"))
tools = YAML.load_file("_data/tools.yml")

markdown = Liquid::Template.parse(body).render(
  "site" => {
    "data" => { "tools" => tools },
    "title" => config["title"],
    "description" => config["description"],
  },
)

content_html = Kramdown::Document.new(markdown).to_html

page = <<~HTML
  <!DOCTYPE html>
  <html lang="#{config["lang"] || "en"}">
  <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>#{config["title"]}</title>
  <style>
    :root { color-scheme: light dark; }
    body {
      max-width: 46rem; margin: 2rem auto; padding: 0 1rem;
      font: 16px/1.6 -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
      background: #fdfdfd; color: #1b1b1b;
    }
    a { color: #2a7ae2; text-decoration: none; }
    a:hover { text-decoration: underline; }
    img { vertical-align: middle; }
    code { background: rgba(127,127,127,.15); padding: .1em .3em; border-radius: 3px; }
    blockquote { border-left: 4px solid rgba(127,127,127,.4); margin: 1em 0; padding: .2em 1em; color: #666; }
    @media (prefers-color-scheme: dark) {
      body { background: #0d1117; color: #e6edf3; }
      a { color: #58a6ff; }
      blockquote { color: #9aa4af; }
    }
  </style>
  </head>
  <body>
  <h1>#{config["title"]}</h1>
  #{content_html}
  <hr>
  <p><em>Local preview — approximates the Minima <code>auto</code> skin. Toggle your OS light/dark mode to test the star badges.</em></p>
  </body>
  </html>
HTML

FileUtils.mkdir_p("_preview")
output = File.join("_preview", "index.html")
File.write(output, page)
puts "Wrote #{output}"
