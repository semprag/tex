% Semantics & Pragmatics style file.
% Kai von Fintel, Christopher Potts, and Chung-chieh Shan

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{sp}[2015/01/04 v.3.0 Class for Semantics & Pragmatics]

%====================================================================
%===================== release notes ================================

% 2025-xx-yy: v4.0, major overhaul
% 2015-01-02: v3.0, include expex option and footnote exx formatting

%======================= Outline ====================================
%====================================================================

% OUTLINE OF THIS CLASS FILE
%   option declarations
%   required packages
%   metadata
%   page dimensions
%   title
%   running headers
%   frontmatter
%   sectioning
%   footnotes
%   bibliography
%   backmatter
%   other environments
%   useful macros

%=====================================================================
%======================== option declarations ========================

% font selection
\newcount\@fontenum
% example-numbering packages
\newcount\@examplenum
% production settings
\newif\if@biblatex

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\newcommand{\@sizeoption@err}{\ClassError{sp}
  {Cannot use size option \CurrentOption}
  {The S&P style requires (and automatically loads) 12pt text}}

\DeclareOption{10pt}{\@sizeoption@err}
\DeclareOption{11pt}{\@sizeoption@err}

% mutually exclusive font selection
\DeclareOption{cm}{\@fontenum=0}
\DeclareOption{times}{\@fontenum=1}
\DeclareOption{lucida}{\@fontenum=2}
\DeclareOption{lucidaot}{\@fontenum=3}
\DeclareOption{defaultot}{\@fontenum=4}
% example-numbering packages
\DeclareOption{expex}{\@examplenum=1}
\DeclareOption{linguex}{\@examplenum=2}
\DeclareOption{gb4e}{\@examplenum=3}
% bibliography option (bibtex default but biblatex used in production)
\DeclareOption{biblatex}{\@biblatextrue}

\ExecuteOptions{times} % times is the default.
\ProcessOptions\relax
\LoadClass[12pt,twoside]{article}

\RequirePackage{iftex}

% amsmath must be loaded before unicode-math; might as well load it here
% doing this via loading mathtools, which fixes & extends amsmath
\RequirePackage[leqno,tbtags]{mathtools}

% missing characters is a serious issue for technical typesetting
\tracinglostchars=3

% Load fonts as indicated by \@fontenum setting.
\ifnum \@fontenum > 2 % lucidaot or defaultot
  \RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}
\fi
\ifcase \@fontenum % 0 = cm
  % Computer Modern is the standard font; do nothing
\or % 1 = times
  \RequirePackage[T1]{fontenc}
  \RequirePackage{mathptmx}
\or % 2 = lucida
  \RequirePackage[romanfamily=bright-osf,scale=0.9,stdmathdigits=true]{lucimatx}
  \let\llbracket\ldbrack
  \let\rrbracket\rdbrack
  \DeclareTextCommand{\textbullet}{\encodingdefault}{\UseTextSymbol{OMS}\textbullet} % the default is tiny
  \DeclareMathSymbol{\nLeftrightarrow}{\mathrel}{arrows}{105} % the default, 103, is too short
\or % 3 = lucidaot
  \defaultfontfeatures{Ligatures=TeX,Scale=0.87}
  % load Lucida font files from local directory if possible
  % three cases: (i) found in texmf tree, (ii) found in local `./fonts`
  % subfolder, (iii) found in system (macOS, in particular)
  \IfFontExistsTF{LucidaBrightOT.otf}{%
    % Case (i): found by `IfFontExistsTF` in texmf tree
    \ClassInfo{sp.cls}{Loading LucidaOT files from texmf tree}
    \defaultfontfeatures+{Extension=.otf}
    % \setmathfont must be called distinctly in each branch
    \setmathfont{LucidaBrightMathOT}
    \setmathfont{LucidaBrightMathOT-Demi}[version=bold]
  }{%
    % moving on to cases (ii) and (iii)
    \IfFileExists{./fonts/LucidaBrightOT.otf}{%
      % Case (ii): file exists in local `./fonts` subfolder
      \ClassInfo{sp.cls}{Loading LucidaOT files from local directory (./fonts/)}
      \defaultfontfeatures+{Path=./fonts/,Extension=.otf}
      % \setmathfont must be called distinctly in each branch
      \setmathfont{LucidaBrightMathOT}
      \setmathfont{LucidaBrightMathOT-Demi}[version=bold]
    }{%
      % Case (iii): we'll better find it in the system
      \ClassInfo{sp.cls}{Loading LucidaOT fonts from system}
      % \setmathfont must be called distinctly in each branch
      \setmathfont{Lucida Bright Math OT}
      \setmathfont{Lucida Bright Math OT Demi}[version=bold]}
  }
  % now that the fonts have been located,
  % load them using their canonical / system names
    % pre-configure the fonts for loading via their canonical / system name
    % by specifying the filenames for each Upright/Bold/Italic/BoldItalic variant
    \defaultfontfeatures[Lucida Bright OT]{
      UprightFont=LucidaBrightOT,
      BoldFont=LucidaBrightOT-Demi,
      ItalicFont=LucidaBrightOT-Italic,
      BoldItalicFont=LucidaBrightOT-DemiItalic,
      Numbers=OldStyle}
    \defaultfontfeatures[Lucida Sans OT]{
      UprightFont=LucidaSansOT,
      BoldFont=LucidaSansOT-Demi,
      ItalicFont=LucidaSansOT-Italic,
      BoldItalicFont=LucidaSansOT-DemiItalic,
      % BoldFeatures = {RawFeature={embolden=2}},
      % BoldItalicFeatures = {RawFeature={embolden=2}}%
    }
    \defaultfontfeatures[Lucida Console DK]{
      UprightFont=LucidaConsoleDK,
      BoldFont=LucidaConsoleDK-Bold,
      ItalicFont=LucidaConsoleDK-Italic,
      BoldItalicFont=LucidaConsoleDK-BoldItalic,
      Scale=MatchLowercase,
      FakeStretch=0.88,
      Ligatures=ResetAll}
  \setmainfont{Lucida Bright OT}
  \setsansfont{Lucida Sans OT}
  \setmonofont{Lucida Console DK}
  % some needed enrichments
  % borrow \ulcorner and \urcorner from Latin Modern OT
  \setmathfont{latinmodern-math.otf}[range={"231C-"231D}]
  % some adjustments
  \let\models\vDash
  \let\nmodels\nvDash
\else % otdefault, will use LatinModern, unless the user specifies their own fonts
  \setmathfont{latinmodern-math.otf}
\fi

\ifnum \@fontenum < 2
  % load shims for non-Lucida fonts (0 = cm and 1 = times)
  \IfFileExists{stmaryrd.sty}{\RequirePackage{stmaryrd}}{
    \ClassWarning{sp.cls}{stmaryrd required but not available; double brackets may be rendered incorrectly}
    \newcommand{\llbracket}{\ensuremath{\left [\!\left [}}
    \newcommand{\rrbracket}{\ensuremath{\right ]\!\right ]}}
  }
  \RequirePackage{textcomp}
  \RequirePackage{amssymb}
\else
  % load extras for Lucida fonts (2 = lucida and 3 = lucidaot)
  \linespread{1.05}
\fi

\ifnum \@fontenum > 2 
  % some older names as aliases for unicode-math commands
  \let\llbracket\lBrack
  \let\rrbracket\rBrack
  \let\leadsto\rightsquigarrow
  \let\Join\bowtie
  \let\Box\mdlgwhtsquare
  \let\Diamond\mdlgwhtdiamond
\fi

% Strong widow and orphan control

\clubpenalty10000
\widowpenalty10000

% French Spacing

\frenchspacing

%=====================================================================
%========================= required packages =========================

\iftutex
\else
  \RequirePackage[utf8]{inputenc}
  % define U+2011 NON-BREAKING HYPHEN as a regular hyphen + line break prohibition
  % Based on http://tex.stackexchange.com/a/23146
  % plain \mbox{-} doesn't allow the suffix to hyphenate automatically
  \DeclareUnicodeCharacter{2011}{\mbox{-}\nobreak\hskip\z@}
\fi
\RequirePackage{xspace}
% microtype handles punctuation at the right margin. We want it for
% the final product, but it's okay if authors lack it.
\IfFileExists{microtype.sty}{%
  \RequirePackage[final,protrusion={true,compatibility},verbose=silent]{microtype}
}{}

% if [biblatex] is requested, check that either the new unified.bbx or the old
% biblatex-sp-unified is available;
% if neither style can be found, fallback to BibTeX.
\if@biblatex
  \IfFileExists{unified.bbx}
    {\RequirePackage[backend=biber,
                    style=unified,
                    natbib,
                    maxcitenames=3,
                    maxbibnames=99]{biblatex}}
    {\IfFileExists{biblatex-sp-unified.bbx}
       {\RequirePackage[backend=biber,
                        bibstyle=biblatex-sp-unified,
                        citestyle=sp-authoryear-comp,
                        natbib,
                        maxcitenames=3,
                        maxbibnames=99]{biblatex}}
       {\ClassWarning{sp.cls}{BibLaTeX requested but cannot find style; falling back to BibTeX}
         \@biblatexfalse}}
\fi

% when a bibentry has a DOI, we should not also display a URL:

\if@biblatex
   \DeclareSourcemap{
        \maps[datatype=bibtex]{
        \map{\step[fieldsource=doi,final]
             \step[fieldset=url,null]
             \step[fieldset=urldate,null]}}}
\fi

\if@biblatex
\else
  \RequirePackage{natbib}
  \bibpunct[: ]{(}{)}{,}{a}{}{,}
  \newcommand{\BIBand}{\&}
  \setlength{\bibsep}{0pt}
  \setlength{\bibhang}{0.25in}
  \bibliographystyle{sp}
  \newcommand{\posscitet}[1]{\citeauthor{#1}'s (\citeyear{#1})}
  \newcommand{\possciteauthor}[1]{\citeauthor{#1}'s}
  \newcommand{\pgposscitet}[2]{\citeauthor{#1}'s (\citeyear{#1}:~#2)}
  \newcommand{\secposscitet}[2]{\citeauthor{#1}'s (\citeyear{#1}:~$\S$#2)}
  \newcommand{\pgcitealt}[2]{\citealt{#1}:~#2}
  \newcommand{\seccitealt}[2]{\citealt{#1}:~$\S$#2}
  \newcommand{\pgcitep}[2]{(\citealt{#1}:~#2)}
  \newcommand{\seccitep}[2]{(\citealt{#1}:~$\S$#2)}
  \newcommand{\pgcitet}[2]{\citeauthor{#1} (\citeyear{#1}:~#2)}
  \newcommand{\seccitet}[2]{\citeauthor{#1} (\citeyear{#1}:~$\S$#2)}
  % \addbibresource{} and \printbibliography are the names of standard
  % BibLaTeX macros, which are shimmed here to call out to normal BibTeX.
  % The \@bibresources variable stores a list of bibliography arguments,
  % which are subsequently loaded by the 0-arity \printbibliography call.
  \def\@bibresources{}
  % \addbibresource mutably appends the given argument to \@bibresources,
  % maintaining \@bibresources as a comma-separated list of arguments.
  \newcommand{\addbibresource}[1]{%
    % \xdef is like \gdef, but immediately expands the second argument.
    \xdef\@bibresources{\@bibresources\ifx\@empty\@bibresources\else,\fi#1}}
  % \printbibliography simply calls the standard BibTeX \bibliography command
  % with the value of the \@bibresources variable (set earlier, as with BibLaTeX).
  \newcommand{\printbibliography}{\bibliography{\@bibresources}}
\fi

\RequirePackage[dvipsnames,table]{xcolor}
\definecolor{splinkcolor}{rgb}{.0,.2,.4}

\RequirePackage{xurl}

\RequirePackage[colorlinks,breaklinks,
                linkcolor=splinkcolor,
                urlcolor=splinkcolor,
                citecolor=splinkcolor,
                filecolor=splinkcolor,
                plainpages=false,
                pdfpagelabels,
                bookmarks=false,
                pdfstartview=FitH]{hyperref}

\newcommand{\doi}[1]{\url{https://doi.org/#1}}
\urlstyle{rm}

\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{caption}
\RequirePackage{subcaption}

%=====================================================================
%============================= metadata ==============================

\def\@pdfauthor{\relax}
\newcommand{\pdfauthor}[1]{\gdef\@pdfauthor{#1}}
\def\@pdftitle{\relax}
\newcommand{\pdftitle}[1]{\gdef\@pdftitle{#1}}
\def\@pdfkeywords{\relax}
\newcommand{\pdfkeywords}[1]{\gdef\@pdfkeywords{#1}}

%=====================================================================
%========================== page dimensions ==========================

\RequirePackage{geometry}

\geometry{
  paperheight=11in,
  paperwidth=8.5in,
  top=1.5in,     
  bottom=1.5in,   
  left=1.5in,
  right=1.5in,
  headheight=0.2in,
  headsep=0.3in,
  footskip=0.5in,
  marginparwidth=1in
}

%=====================================================================
%============================== title ================================

% Formats individual <name--institute> pairs inside \author.
\newcommand{\spauthor}[1]{%
  \begin{minipage}[t]{16pc}\centering #1\end{minipage}\hspace{.5pc plus1pc}%
  \ignorespaces
}

\renewcommand*{\title}[2][]{\gdef\@shorttitle{#1}\gdef\@title{#2}}
\renewcommand*{\author}[2][]{\gdef\@shortauthor{#1}\gdef\@author{#2}}

% Adapted from JMLR.
\renewcommand{\maketitle}{%
  \par
  \begingroup
  \renewcommand{\thefootnote}{\fnsymbol{footnote}}
  \@maketitle\@thanks
  \setcounter{footnote}{0}
  \endgroup
  \let\maketitle\relax \let\@maketitle\relax
  \gdef\@thanks{}
  \let\thanks\relax%
}

% From salt.cls.
\newskip\onelineskip
\onelineskip=\baselineskip
\advance\onelineskip by0pt plus 4pt minus 2pt

\def\@maketitle{%
  \vbox{\hsize\textwidth%
    \linewidth\hsize%
    \centering
    \vskip\onelineskip
    \large\textbf{\@title}\@@par
    \normalsize
    \def\institute{\textit}%
    \newcommand{\AND}{\ignorespaces}%
    \let\par\@empty
    \@author
    \lineskiplimit\onelineskip
    \lineskip\onelineskip
    \@@par
  }%
  \global\everypar{\everypar{}\vskip 3.5ex}
}

%=====================================================================
%========================== running headers ==========================

% Prints abbreviated article information on non-initial pages.
\def\ps@spheadings{
  \let\@mkboth\@gobbletwo
  % short title on inner (left) side
  \def\@oddhead{\footnotesize\@shorttitle\hfill}
  % author name(s) on inner (right) side
  \def\@evenhead{\footnotesize\hfill\@shortauthor}
  % centered page number on all pages
  \def\@oddfoot{\footnotesize\hfill\thepage\hfill}
  \let\@evenfoot\@oddfoot
}
% set spheadings as default pagestyle throughout document
\pagestyle{spheadings}

% load minimal metadata for non-final (or non-S&P) pdfs
\hypersetup{%
  pdfauthor=\@pdfauthor,
  pdftitle=\@pdftitle,
  pdfkeywords=\@pdfkeywords}
\thispagestyle{empty}

%=====================================================================
%=========================== frontmatter =============================

% The spacing specs (arg 2 of \list) are the same for the mshistory,
% abstract, and keywords environments, except that the abstract is
% indented somewhat.

% Single parameter determines the left and right margin size.
\newcommand{\frontmatterspacing}[1]{%
  \small
  \topsep 10\p@ \@plus4\p@   \@minus6\p@ % from size12.clo
  \advance\topsep by3.5ex plus -1ex minus -.2ex
  \setlength{\listparindent}{0em}
  \setlength{\itemindent}{0em}
  \setlength{\leftmargin}{#1}
  \setlength{\rightmargin}{\leftmargin}
  \setlength{\parskip}{0em}
}

\newenvironment{mshistory}%
{\list{}{\frontmatterspacing{0em}}%
\item\relax}%
{\endlist}

% \ignorespacesandpars inspired by http://tex.stackexchange.com/a/179034/3642
\def\ignorespacesandpars{%
  \@ifnextchar\par{\expandafter\ignorespacesandpars\@gobble}{\ignorespaces}}

\renewenvironment{abstract}%
{\list{}{\frontmatterspacing{0.25in}}%
\item\relax\textbf{\abstractname}~~\ignorespacesandpars}%
{\endlist}

\newenvironment{keywords}%
{\list{}{\frontmatterspacing{0em}}%
\item\relax\textbf{Keywords:}}%
{\endlist}

%=====================================================================
%============================ sectioning =============================

\renewcommand{\section}{\@startsection{section}{1}{\z@}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalfont\bfseries}}

\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalfont\bfseries}}

\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
  {-3.5ex plus -1ex minus -.2ex}%
  {1.8ex plus.2ex}%
  {\noindent\normalfont\bfseries}}

\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
  {3.5ex plus 1ex minus .2ex}%
  {-1em plus0.0ex}%
  {\noindent\normalsize\bfseries}}

\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
  {3.5ex plus 1ex minus .2ex}%
  {-1em plus0.0ex}%
  {\noindent\normalsize\it}}

% General formatting --- for punctuating section headings.
\renewcommand{\@seccntformat}[1]{\@nameuse{the#1}\hspace{1em}}

%=====================================================================
%============================ footnotes ==============================

\renewcommand{\@makefntext}[1]{%
  \parindent=0.25in
  \noindent \hbox to \z@{\hss{\@thefnmark} \hfil}#1}

%=====================================================================
%============================ backmatter =============================

% Environment for formatting all the addresses.
\newenvironment{addresses}%
 {\@@par\let\par\@empty\addvspace{3.25ex}\small\ignorespaces}%
 {\lineskiplimit 1pc\lineskip 1pc\@@par}
% Sub-environment for formatting each individual author's address.
\newenvironment{address}[1][.5\textwidth]%
 {\noindent\ignorespaces\begin{minipage}[t]{#1}\raggedright}%
 {\end{minipage}\allowbreak\ignorespacesafterend}

%=====================================================================
%======================== other environments =========================

% enumerate labeling that won't conflict with standard ex. numbers.
\renewcommand{\theenumi}{\roman{enumi}}
\renewcommand{\labelenumi}{\theenumi.}
\renewcommand{\theenumii}{\alph{enumii}}
\renewcommand{\labelenumii}{\theenumii.}

% list spacing ought to satisfy \itemsep + \parsep < \topsep + \parskip
\def\@listi{\leftmargin\leftmargini
            \parsep 4\p@  \@plus2\p@ \@minus\p@
            \topsep 10\p@ \@plus4\p@ \@minus\p@
            \itemsep4\p@  \@plus2\p@ \@minus\p@}
\let\@listI\@listi
\@listi

\DeclareCaptionFormat{sp}{%
  \parbox[t]{60pt}{#1}%
  \parbox[t]{\dimexpr\textwidth-60pt\relax}{#2#3}%
}
\captionsetup{
  format=sp,
  font=normalsize,
  labelfont={normalfont,bf},
  labelsep=none,
  skip=\medskipamount
}
\DeclareCaptionSubType*{figure}
\DeclareCaptionSubType*{table}
\captionsetup[subfigure]{%
  margin=0pt,
  position=bottom,
  skip=0.5ex,
  format=plain
}
\newcommand\fs@sp{%
  \def\@fs@cfont{\bfseries}%
  \let\@fs@capt\floatc@sp
  \def\@fs@pre{\hrule\kern5pt}%
  \def\@fs@post{\kern5pt\hrule\relax}%
  \def\@fs@mid{\kern10pt}%
  \let\@fs@iftopcapt\iffalse}
\floatstyle{sp}
\restylefloat{figure}
\restylefloat{table}

%=====================================================================
%=========================== useful macros ===========================

\def\co{\colon\thinspace}

\DeclareRobustCommand\dash{%
  \unskip\nobreak\thinspace\textemdash\thinspace\ignorespaces}
\pdfstringdefDisableCommands{\renewcommand{\dash}{ - }}

% based on \url defined in hyperref.sty
\DeclareRobustCommand*{\http}{\hyper@normalise\http@}
\def\http@#1{\hyper@linkurl{\Hurl{#1}}{http://#1}}

\newcommand{\email}[1]{\href{mailto:#1}{#1}}

\providecommand{\sv}[1]{\ensuremath{\llbracket{#1}\rrbracket}}

%=====================================================================
%====================== example package settings =====================

\ifnum \@examplenum = 1
  \RequirePackage{expex}%
  \lingset{%
    exskip=-0.5ex,
    interpartskip=0.5ex,
    aboveexskip=1ex,
    belowexskip=2ex,
    everygla=}
  \ifxetex
    \let\expexgla\gla%
    \AtBeginDocument{\let\gla\expexgla}
  \fi
  \def\everyfootnote{%
    \keepexcntlocal
    \excnt=1
    % exskip: sets aboveexskip and belowexskip at the same time
    % exnotype: sets the family for root example numbering (default: arabic)
    %           (must be one of: arabic, chapter.arabic, or roman)
    % sampleexno: sets root example to constant width (default: no constant width)
    % labeltype: sets the family for subexample numbering (default: alpha)
    % labelanchor: sets left alignment of subexample (default: numright)
    % labeloffset: left margin of subexample numbering (default: 1em)
    % textoffset: distance between subexample numbering and text (default: 1em)
    \lingset{exskip=1ex,exnotype=roman,labeloffset=.6em,textoffset=.6em}
  }
  \renewcommand{\@makefntext}[1]{%
    \everyfootnote
    \parindent=0.25in
    \noindent \hbox to \z@{\hss{\@thefnmark} \hfil}#1%
  }
  \gathertags
\fi

\ifnum \@examplenum = 2
  \AtEndPreamble{\RequirePackage{linguex}}%
  \AtEndPreamble{\renewcommand{\firstrefdash}{}}%
  \AtBeginDocument{\settowidth{\Exlabelwidth}{(110)}}
\fi

\ifnum \@examplenum = 3
  \AtBeginDocument{\RequirePackage{gb4e-emulate}}
\fi



%================================ fin ================================
%=====================================================================
