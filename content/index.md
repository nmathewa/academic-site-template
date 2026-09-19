---
title: Example research note
subtitle: A Markdown page built with pandoc in the MJO Track Archive style
date: 18 September 2026
abstract: >-
  This page shows every element of the template: the title block, sections, a numbered figure
  and table with cross-references, an equation, callouts, code, and citations with a reference
  list. Write in Markdown, run `make`, and open `_site/index.html`.
contents: true              # list this page's sections under the title block
---

## Writing a page

Every file in `content/` becomes a page in `_site/`. Shared settings — site name, author,
affiliation, logo and the navigation line — live in `site.yaml`; anything in a page's front
matter overrides them.

Text is ordinary Markdown. Citations use pandoc's syntax: the RMM index [@wheeler2004] and
Large-scale Precipitation Tracking [@kerns2016; @kerns2020], or in-text as @wheeler2004.

## Figures

![Eastward displacement against lead time for a model and a baseline. Figures are numbered
automatically; refer to them by label.](img/example.svg){#fig:example width="100%"}

@fig:example is referenced by its label, so numbers stay right when figures move. Add
`.wide` to let a figure use the full page width: `![...](img/x.png){#fig:x .wide}`.

## Tables

| Forecaster        | 1 d | 5 d  | 10 d | 15 d |
|:------------------|----:|-----:|-----:|-----:|
| persistence       | 4.1 | 13.5 | 20.5 | 26.5 |
| linear            | 3.8 | 13.1 | 19.2 | 23.9 |
| analogs           | 3.9 | 13.2 | 19.2 | 23.7 |

Table: Zonal error of the ensemble mean (° longitude), cross-validated. {#tbl:skill}

@tbl:skill uses a caption line starting with `Table:` and an `{#tbl:…}` label.

## Equations

Equations are written in LaTeX and rendered as MathML, so no script is needed:

$$ \mathrm{CRPS}(F, y) = \mathbb{E}\,|X - y| - \tfrac{1}{2}\,\mathbb{E}\,|X - X'| $$

## Callouts

::: callout
**Key result.** A `callout` block highlights a finding, in the accent colour.
:::

::: caveat
**Caveat.** A `caveat` block flags a limitation, in the second accent colour.
:::

::: note
A `note` block is quieter, for side remarks.
:::

## Code

```bash
make          # build every page into _site/
make serve    # build, then serve on http://0.0.0.0:8010
```

## References {#references}

::: {#refs}
:::
