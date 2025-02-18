% Semantics & Pragmatics wrapper for final production
% Kai von Fintel

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{sp-final}[2025/01/29 v.1.0 Wrapper for final production]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{sp}}
\ProcessOptions\relax
\LoadClass{sp}

% As of hyperxmp v5.12, dated 2023/09/10, hyperxmp is supposed to be loaded after hyperref
% but before any \hypersetup commands, so we load it now

\RequirePackage{hyperxmp}

% tell hyperref/hyperxmp to keep pdf info of the old kind
\hypersetup{keeppdfinfo}

\def\@spvolume{}
\newcommand{\spvolume}[1]{\gdef\@spvolume{#1}}

\def\@sparticle{}
\newcommand{\sparticle}[1]{\gdef\@sparticle{#1}}

\def\@spyear{}
\newcommand{\spyear}[1]{\gdef\@spyear{#1}}

\def\@spdoi{10.3765/sp.\@spvolume.\@sparticle}

\def\@splastpage{}
\newcommand{\splastpage}[1]{\gdef\@splastpage{#1}}

\newcommand{\copyrightowner}[1]{\gdef\@copyrightowner{#1}}

% Prints publication and copyright info on the first page
\def\ps@spfirstheadings{
  \let\@mkboth\@gobbletwo
  \def\@oddhead{%
    \footnotesize
    \begin{minipage}[c]{.25in}
     \IfFileExists{sp-logo.pdf}{\includegraphics[width=\textwidth]{sp-logo}}{}
    \end{minipage}%
    \begin{minipage}[c]{5.25in}
      \href{http://semprag.org/}{Semantics \& Pragmatics}
        Volume \@spvolume,
        Article \@sparticle\ifx\@empty\@splastpage\else: 1--\@splastpage\fi,
        \@spyear\\
      \href{https://doi.org/\@spdoi}{https://doi.org/\@spdoi}
    \end{minipage}%
  }
  \def\@oddfoot{%
    \footnotesize
    \begin{minipage}[c]{\textwidth}
      \copyright \@spyear\ \@copyrightowner\\
      % Creative commons license text.
      This is an open-access article distributed under the terms of a
      Creative Commons Attribution License
      (\url{https://creativecommons.org/licenses/by/3.0/}).
    \end{minipage}%
  }
  \def\@evenhead{}
  \def\@evenfoot{}
}

% centered page number (with article prefix if available) on all pages
\def\@oddfoot{\footnotesize\hfill\ifx\@empty\@sparticle\else\@sparticle:\fi\thepage\hfill}
\let\@evenfoot\@oddfoot

\newenvironment{mshistory}%
{\list{}{\frontmatterspacing{0em}}%
\item\relax}%
{\endlist}

% load global variables into metadata
\AfterEndPreamble{%
    \hypersetup{%
      unicode=true,
      pdfmetalang={en},
      pdfcopyright={Copyright \@spyear, \@copyrightowner. This is an open-access article distributed under the terms of a Creative Commons Non-Commercial License (http://creativecommons.org/licenses/by-nc/3.0).},%
      pdflicenseurl={http://creativecommons.org/licenses/by-nc/3.0},%
      pdfsubject={Semantics and Pragmatics \@spvolume(\@sparticle). \@spyear. \@spdoi},%
      pdfpublisher={The Linguistics Society of America},%
      pdfpublication={Semantics and Pragmatics},%
      pdfpagerange={1-\@splastpage},%
      pdfdoi={\@spdoi},%
      pdfpubtype={journal},%
      pdfissn={1937-8912},%
      pdfurl={https://doi.org/\@spdoi},%
      pdfvolumenum={\@spvolume},%
      pdfissuenum={\@sparticle}}}
\thispagestyle{spfirstheadings}
