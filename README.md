# Academic site template (pandoc)

Write pages in Markdown; build a static site with the look of the
[MJO Track Archive](https://nmathewa.github.io/mjo-tracker/): serif text, sans labels, thin rules,
numbered figures and tables with cross-references, citations, light/dark themes.

Nirmal Mathew Alex, Florida Institute of Technology

## Use

Needs [pandoc](https://pandoc.org/installing.html) ≥ 3.1 and `make` (Python only for `make serve`).

```bash
make          # content/*.md -> _site/*.html
make serve    # build and serve on http://0.0.0.0:8010 (LAN / Tailscale too)
make clean
```

## Layout

| path | what |
|---|---|
| `content/*.md` | one page each; front matter: `title`, `subtitle`, `date`, `abstract`, `contents: true` |
| `content/img/` | figures (copied to `_site/img/`) |
| `content/references.bib` | BibTeX for `[@key]` citations |
| `site.yaml` | shared settings: site name, eyebrow, author, affiliation, logo, navigation, footer |
| `templates/page.html` | the pandoc HTML template |
| `assets/css/style.css` | all styling; colour tokens at the top (light and dark) |
| `filters/crossref.lua` | numbers figures/tables and resolves `@fig:id` / `@tbl:id` |

## Writing

```markdown
![Caption text.](img/plot.svg){#fig:plot}          see @fig:plot
Table: Caption text. {#tbl:skill}                    see @tbl:skill
Cited in brackets [@wheeler2004] or in text @wheeler2004.
$$ E = mc^2 $$                                       (rendered as MathML)
::: callout / ::: caveat / ::: note                  highlighted blocks
```

End a page with `::: {#refs}` / `:::` under a References heading to place the reference list.
To change the citation style, add `csl: path/to/style.csl` to `site.yaml`
(styles: <https://github.com/citation-style-language/styles>).

## Publish (optional)

`.github/workflows/pages.yml` builds and deploys to GitHub Pages when run by hand
(Actions → Build site → Run workflow), after enabling Pages with source "GitHub Actions".
