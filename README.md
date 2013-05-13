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

`metabibtex.py` wrangles proceedings metadata (the `*_metadata.txt` files found in the `final/` directory of the ACLPUB proceedings tarball) to produce two things:

1. A rudimentary `.bib`  file with author names and paper titles.
2. `.tex` files with paper titles and abstracts.

These `.tex` files are included in the main handbook via the `\input` command.

    meta2bibtex.py
	  usage: meta2bibtex.py <'final' dir> <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)

`order2schedule.perl` wrangles the `order` files (which specify the day-to-day schedule of workshops, demos, *etc*.) that are found in the proceedings tarball to produce:

1. Possibly many files that are designed to produce nice-looking `.pdf`-rendered schedules in the final handbook.

These schedules are included in the main handbook via the `\input` command.

**NOTE**: this works for the style of `order` file we used for the proceedings. **YOU MAY NEED TO EDIT THIS SCRIPT FOR THE PURPOSES OF YOUR SPECIFIC CONFERENCE!**

    order2schedule.perl
	  usage: cat order | order2schedule.perl <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)

`starsem.order2schedule.perl` is a specialized version of `order2schedule.perl` which is used for parallel sessions with non-synchronized paper slots.

	starsem.order2schedule.perl
	  usage: cat order | semstar.order2schedule.perl <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)

`singletrack.order2schedule.perl` is a specialized version of `order2schedule.perl` which is used for single-track events, like workshops.

	singletrack.order2schedule.perl
	  usage: cat order | singletrack.order2schedule.perl <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)

`fix-index.perl` is a script that fixes the `.idx` file that is produced by running `latex` on the document. This does things like remove the accents from authors for proper sorting in the author index. This is called by the makefile.

    fix-index.perl
	  usage: (please use the makefile)

#### texmf/
Contains tex modules required to produce handbook. You probably want to either (1) copy this into your local tex directory (often `~/texmf/`) and run `texconfig rehash`, or (2) include this file in the appropriate env settings, so they get found by tex.

#### Makefile
Used to control various build processes

#### README.md
You are here. Your friendly neighborhood readme file.





