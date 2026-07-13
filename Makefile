.PHONY: help install preview open clean

help: ## Show help for each of the Makefile targets
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z0-9_.-]+:.*##/ {printf "%-10s %s\n", $$1, $$2}' $(MAKEFILE_LIST) 2>/dev/null || true

install: ## Install Ruby dependencies (liquid, kramdown)
	bundle install

preview: ## Render index.md -> _preview/index.html
	bundle exec ruby script/preview.rb

open: preview ## Render the preview and open it in your browser
	open _preview/index.html

clean: ## Remove generated preview output
	rm -rf _preview
