# CREATING A CONFERENCE HANDBOOK FROM ACLPUB DUMPS

### 2012 Ulrich Germann
### 2013 Alex Clemmer <clemmer.alexander@gmail.com>


# Directory structure

    doc/
      aclpub-setup.tex
      chbk-howto.tex
    scripts/
    texmf/
    Makefile
    README.md

This document describes how to create conference handbooks from ACLPUB dumps (tar balls)
from the START conference management system.

In this directory:

   Makefile: Makefile for automating the latex compilation process.
             % make docu
	     should create chbk-howto.pdf and aclpub-setup.pdf
	     chbk-howto.pdf is the file you should look at first.

   handbook.tex: the master document for the handbook
   chbk-howto.tex: source file for instructions on how to create handbooks
   aclpub-setup.tex: source file for instructions on how to get an aclpub tar
                     ball out of the START system

   texmf:   local texmf directory with latex packages required to produce the handbook
            rsync this with your local texmf directory (typically $HOME/texmf) or set
	    the proper environment variables (whose name depends on your local flavor of latex)
	    to include this directory.

   scripts: scripts and related modules for extracting information from the ACLPUB tarballs

   	    meta2bibtex.py
	    - preprocessor for the meta-info in the 'final' directory of an aclpub proceedings tarball
	    - usage: meta2bibtex.py <'final' dir> <tag>
              where <tag> is a tag for the part of the conference (e.g. main, demos, worshops)

	    order2schedule.perl
	    semstar.order2schedule.perl
	    singletrack.order2schedule.perl
	    - convert the 'order' file from the proceedings tarball into snippets for inclusion
	      in the tex document
	    - usage: cat order | order2schedule.perl <tag>
              where <tag> is a tag for the part of the conference (e.g. main, demos, worshops)

   content: manually edited content of the conference handbook
      content/special: special files: preamble and macros
      content/setup:   define commands to automate parts of the handbook creation
      content/day{1|2|...} folders for individual conference days
