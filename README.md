# Academic site template (pandoc)

Write pages in Markdown; build a static site with the look of the
[MJO Track Archive](https://nmathewa.github.io/mjo-tracker/): serif text, sans labels, thin rules,
numbered figures and tables with cross-references, citations, light/dark themes.

Nirmal Mathew Alex, Florida Institute of Technology

## 1. Clone

Start your own site from this template (keeps your history separate):

```bash
gh repo create my-site --template nmathewa/academic-site-template --public --clone
cd my-site
```

or on GitHub: **Use this template → Create a new repository**, then `git clone` it.
To just try it:

```bash
git clone https://github.com/nmathewa/academic-site-template.git
cd academic-site-template
```

Needs [pandoc](https://pandoc.org/installing.html) ≥ 3.1 and `make`; Python 3 only for serving.
Pandoc can live in your home directory, no admin rights needed:

```bash
mkdir -p ~/.local/bin
curl -sL https://github.com/jgm/pandoc/releases/download/3.11/pandoc-3.11-linux-amd64.tar.gz | tar xz -C /tmp
cp /tmp/pandoc-3.11/bin/pandoc ~/.local/bin/     # make sure ~/.local/bin is on your PATH
pandoc --version
```

## 2. Edit

1. **Site settings** — `site.yaml`: site name, eyebrow line, author(s), affiliation, logo,
   navigation links and footer. These apply to every page.
2. **Pages** — each `content/*.md` is one page (`content/about.md` → `about.html`). Start from
   `content/index.md`, which shows every feature. Front matter per page:

   ```yaml
   ---
   title: My results
   subtitle: One line under the title
   date: 18 September 2026
   abstract: >-
     Shown as the "Summary." paragraph under the byline.
   contents: true          # optional: list this page's sections
   ---
   ```

   Add new pages to `nav:` in `site.yaml` so they appear in the navigation line.
3. **Figures** — put images in `content/img/` and write
   `![Caption.](img/plot.png){#fig:plot}`; refer to it as `@fig:plot`.
4. **Citations** — add BibTeX entries to `content/references.bib`, cite with `[@key]`.
5. **Look** — colours are tokens at the top of `assets/css/style.css` (light, then dark);
   replace `assets/img/logo.svg` for your own logo.
6. Rebuild with `make` after each change (only changed pages are rebuilt).

## 3. Serve

```bash
make serve                 # build, then serve _site/ on http://0.0.0.0:8010
make serve PORT=8080       # another port
```

Open <http://localhost:8010> on this machine. Because it binds to `0.0.0.0`, other devices can
use `http://<this-machine-ip>:8010` on the same network, or the machine's Tailscale address.
Stop with Ctrl+C. `_site/` is plain static HTML, so any web server (or GitHub Pages, below)
can host it. `make clean` removes it.

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
