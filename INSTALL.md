## S&P TeX installation

We are going to install everything to our "TeX & Metafont" (`TEXMF`) home folder.
This is where all of your custom styles should be installed, so you may have a lot of this structure already.

`kpsewhich --var-value TEXMFHOME` will return the path to your `TEXMFHOME` home folder.
For the rest of these instructions, I'll assume that the environment variable `$TEXMFHOME` is set to that directory.
(In fact, if you set export the `TEXMFHOME` variable, `kpsewhich` will use that value instead.)

The files should be placed like so:

    $TEXMFHOME
    └── tex
        └── latex
            ├── biblatex
            │   ├── bbx
            │   │   └── biblatex-sp-unified.bbx
            │   └── cbx
            │       └── sp-authoryear-comp.cbx
            ├── sp-hyperxmp.sty
            ├── sp-logo.pdf
            └── sp.cls
