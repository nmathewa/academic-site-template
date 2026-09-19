# Build the site from Markdown with pandoc.
#   make          build _site/
#   make serve    build, then serve on http://0.0.0.0:8000 (reachable on your LAN / Tailscale)
#   make clean    remove _site/
PANDOC ?= pandoc
PORT   ?= 8000
PAGES  := $(patsubst content/%.md,_site/%.html,$(wildcard content/*.md))
DEPS   := templates/page.html site.yaml filters/crossref.lua $(wildcard content/*.bib)

all: $(PAGES) _site/assets _site/img

_site/%.html: content/%.md $(DEPS)
	@mkdir -p _site
	$(PANDOC) $< -o $@ --standalone --template templates/page.html \
	  --metadata-file site.yaml --lua-filter filters/crossref.lua \
	  --citeproc --bibliography content/references.bib \
	  --math-method=mathml --section-divs --toc --toc-depth 2

_site/assets: $(shell find assets -type f)
	@mkdir -p _site && rm -rf _site/assets && cp -r assets _site/assets

_site/img: $(shell find content/img -type f 2>/dev/null)
	@mkdir -p _site && rm -rf _site/img && cp -r content/img _site/img

serve: all
	python3 -m http.server $(PORT) -d _site --bind 0.0.0.0

clean:
	rm -rf _site

.PHONY: all serve clean
