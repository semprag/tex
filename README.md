# The S&P LaTeX system

This repository contains the basic files necessary to typeset articles with the S&P style.
The S&P BibLaTeX system (`biblatex-sp-unified.bbx` and `sp-authoryear-comp.cbx`) has its own repository: [semprag/biblatex-sp-unified](https://github.com/semprag/biblatex-sp-unified).

Installation instructions are available at [info.semprag.org/install](http://info.semprag.org/install).

* [`sp.cls`](sp.cls): The canonical, latest version of the main S&P document class.
* [`gb4e-emulate.sty`](gb4e-emulate.sty): For S&P-style rendering of examples using `gb4e` syntax. We encourage the use of `expex` for examples; `gb4e-emulate.sty` is only provided to typeset papers where the author chose to use `gb4e`.
* [`sp-logo.pdf`](sp-logo.pdf): the S&P logo
* [`sp-hyperxmp.sty`](sp-hyperxmp.sty): a package to add metadata to the PDFs produced

The logo file and sp-hyperxmp.sty are only needed for the final typeset, when the S&P production team is ready to publish a paper. Authors do not need these files.

[License](LICENSE)
