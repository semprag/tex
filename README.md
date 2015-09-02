# The S&P LaTeX system

This repository contains all the files necessary to typeset articles with the S&P style.

The essential files are:

* sp.cls -- the S&P document class
* biblatex-sp-unified.bbx -- the S&P BibLaTeX bibliography style
* sp-authoryear-comp.cbx -- the S&P BibLaTeX citation style

See INSTALL.md for where these files should go.

There are three additional files:

* gb4e-emulate.sty -- for typesetting gb4e style linguistic examples
* sp-logo.pdf -- the S&P logo
* sp-hyperxmp.sty -- a package to add metadata to the PDFs produced

We encourage the use of expex for examples. gb4e-emulate.sty is only provided to typeset papers where the author chose to use gb4e.

The logo file and sp-hyperxmp.sty are only needed for the final typeset, when the S&P production team is ready to publish a paper. Authors do not need these files.

More information about the S&P BibLaTeX system can be found at its dedicated repository: https://github.com/semprag/biblatex-sp-unified.
