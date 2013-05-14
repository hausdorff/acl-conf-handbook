## CREATING A CONFERENCE HANDBOOK FROM ACLPUB DUMPS

*Author history:*

| Year      | Author         | Email                         |
| --------- |:--------------:| :---------------------------- |
| 2013      | Alex Clemmer   | <clemmer.alexander@gmail.com> |
| 2012      | Ulrich Germann |                               

(Includes many many legacy scripts generously contributed from previous years!)

# Table of contents

| Section                                                                                   | Description                                         |
| :---------------------------------------------------------------------------------------- | :-------------------------------------------------- |
| [Directory Structure](https://github.com/hausdorff/acl-conf-handbook#directory-structure) | *What does each of these files in this project do?* |
| [How to build](https://github.com/hausdorff/acl-conf-handbook#how-to-build)               | *How do I build an ACL-like handbook?*              |

# Directory structure
*What does each of these files in this project do?*

The critical moving parts you will need to generate an ACL-style conference handbook are structured in a directory tree that is designed to approximately make sense. Here we'll show the tree structure, and explain each file inside it.

    doc/
        aclpub-setup.tex
        chbk-howto.tex
    input/
        demo/
            final/
                <some directories>/*_metadata.txt
            order
        workshops/
            <workshop>/
                final/
                    <some directories>/*_metadata.txt
                order
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

### doc/
Contains the `.tex` files that generate `.pdf` files that document how to make a handbook.

### input/
Contains most of the data that we will use to generate `.pdf` renderings of the schedules for things like demos and workshops. Accordingly, this directory is partitioned between (*e.g.*) `workshops/` and `demo/` so that the data is kept neat and tidy.

More will be said about how to use this data when we talk about assembling the handbook, but there are generally two types of file: `order` files and `*_metadata.txt` files. The former contains a formatted representation of the schedules we'll use to generate nice `.pdf` renderings of the schedules. The latter are used to generate `.bib` files and `.tex` files containing information about the papers.

Again, more will be said about this as we talk about the build process.

### scripts/
Contains scripts for extracting information out of ACLPUB tarballs. Currently there are 5 scripts that would get heavy use:

#### 1 `scripts/metabibtex.py`
Wrangles proceedings metadata (the `*_metadata.txt` files found in the `final/` directory of the ACLPUB proceedings tarball) to produce two things:

1. A rudimentary `.bib`  file with author names and paper titles.
2. `.tex` files with paper titles and abstracts.
3. (Currently, all of this will go into the `auto/` directory!)

These `.tex` files are included in the main handbook via the `\input` command.

    meta2bibtex.py
	  usage: meta2bibtex.py <'final' dir> <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)

#### 2 `scripts/order2schedule.perl`
Wrangles the `order` files (which specify the day-to-day schedule of workshops, demos, *etc*.) that are found in the proceedings tarball to produce:

1. Possibly many files that are designed to produce nice-looking `.pdf`-rendered schedules in the final handbook.
2. (Currently, all of this will go into the `auto/` directory!)

These schedules are included in the main handbook via the `\input` command.

**NOTE**: this works for the style of `order` file we used for the proceedings. **YOU MAY NEED TO EDIT THIS SCRIPT FOR THE PURPOSES OF YOUR SPECIFIC CONFERENCE!**

    order2schedule.perl
	  usage: cat order | order2schedule.perl <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)

#### 3 `scripts/starsem.order2schedule.perl`
A specialized version of `order2schedule.perl` which is used for parallel sessions with non-synchronized paper slots.

	starsem.order2schedule.perl
	  usage: cat order | semstar.order2schedule.perl <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)

#### 4 `scripts/singletrack.order2schedule.perl`
A specialized version of `order2schedule.perl` which is used for single-track events, like workshops.

	singletrack.order2schedule.perl
	  usage: cat order | singletrack.order2schedule.perl <tag>
             where <tag> is a tag for the part of the
             conference (e.g. main, demos, worshops)

#### 5 `scripts/fix-index.perl`
A script that fixes the `.idx` file that is produced by running `latex` on the document. This does things like remove the accents from authors for proper sorting in the author index. This is called by the makefile.

    fix-index.perl
	  usage: (please use the makefile)

### texmf/
Contains tex modules required to produce handbook. You probably want to either (1) copy this into your local tex directory (often `~/texmf/`) and run `texconfig rehash`, or (2) include this file in the appropriate env settings, so they get found by tex.

### Makefile
Used to control various build processes

### README.md
You are here. Your friendly neighborhood readme file.



# How to build



#separator 

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
