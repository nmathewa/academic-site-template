# academic-site-template — Markdown + pandoc academic website template

Template repo (public, "Use this template"): pages written in Markdown, built with pandoc into a
static site with the look of the MJO Track Archive. Author: Nirmal Mathew Alex, Florida Institute of
Technology. Repo: github.com/nmathewa/academic-site-template.

## Rules from the user
- Runs locally with `make`; keep it simple (no JS framework, no node). Everything under `/home/nma`:
  pandoc 3.11 is the binary in `~/.local/bin/pandoc` — never install to system paths.
- The GitHub Pages workflow is manual-only (`workflow_dispatch`), so it costs nothing unless run.
- Keep the README sections: Clone, Edit, Serve.

## Layout
- `content/*.md` — one page each. Front matter: `title`, `subtitle`, `date`, `abstract` (rendered as
  the "Summary." paragraph; label via `summary-title`), `contents: true` (page contents list).
- `site.yaml` — shared metadata: `site`, `eyebrow`, `author`, `affiliation`, `logo`, `root`, `nav`
  (title/href list), `footer`. Page front matter overrides it.
- `templates/page.html` — pandoc template: title block (eyebrow, logo + title, subtitle, byline,
  summary, nav), optional contents, `<main class="paper">`, footer, theme button.
- `filters/crossref.lua` — numbers figures/tables ("Figure 1.", "Table 1.") and turns `@fig:id` /
  `@tbl:id` into links; runs before `--citeproc` so those ids never reach the bibliography.
- `assets/css/style.css` — all styling; colour tokens on `:root` (light) and repeated for dark
  (`prefers-color-scheme` + `[data-theme]`). Okabe–Ito blue/vermillion, Source Serif 4 / Source Sans 3.
- `assets/js/theme.js` — auto/light/dark toggle, remembered in localStorage.
- `content/references.bib` — citations (`[@key]`); default CSL is pandoc's Chicago author-date.

## Commands
```bash
make              # content/*.md -> _site/*.html (pandoc --citeproc --math-method=mathml --toc)
make serve        # build + python3 -m http.server on 0.0.0.0:8010 (port 8000 is taken locally)
make clean
```

## Conventions
- Figures: `![Caption.](img/x.svg){#fig:x}`; tables: `Table: Caption. {#tbl:y}`.
- Callouts: fenced divs `::: callout`, `::: caveat`, `::: note`.
- Reference list: `::: {#refs}` / `:::` under a References heading.
- Check a change by building and opening `_site/index.html` in light and dark, desktop and 390 px.
