## CREATING A CONFERENCE HANDBOOK FROM ACLPUB DUMPS

*Author history:*

2013 Alex Clemmer <clemmer.alexander@gmail.com>

2012 Ulrich Germann

(Includes many many legacy scripts generously contributed from previous years!)

# Directory structure
*What do each of the files in this project do?*

The critical moving parts you will need to generate an ACL-style conference handbook are structured in a directory tree that is designed to approximately make sense. Here we'll show the tree structure, and explain each file inside it.

    doc/
      aclpub-setup.tex
      chbk-howto.tex
    scripts/
      extract-data.sh
      fix-index.perl
      insert_index.perl
      meta2bibtex.py
      order2schedule.perl
      paper_info.py
      singletrack.order2schedule.perl
      starsem.order2schedule.perl
    texmf/
    Makefile
    README.md

#### doc/
Contains the `.tex` files that generate `.pdf` files that document how to make a handbook.

#### scripts/
Contains scripts for extracting information out of ACLPUB tarballs. Currently there are 4 scripts that would get heavy use:

`metabibtex.py` preprocesses the meta-info in the 'final' directory of an aclpub proceedings tarball:

    meta2bibtex.py
	  usage: meta2bibtex.py <'final' dir> <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)

These `perl` files convert various flavors of 'order' file from the proceedings tarball into snippets for inclusion in the tex document.

    order2schedule.perl
	semstar.order2schedule.perl
	singletrack.order2schedule.perl
	  usage: cat order | order2schedule.perl <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)


#### texmf/
Contains tex modules required to produce handbook. You probably want to either (1) copy this into your local tex directory (often `~/texmf/`) and run `texconfig rehash`, or (2) include this file in the appropriate env settings, so they get found by tex.



