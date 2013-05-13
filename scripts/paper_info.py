#!/usr/bin/env python 
# -*- coding: utf-8 -*-

# Module that provides access to the information in the aclpub metadata files.
# Written by Ulrich Germann, May 2012.
import re, codecs

class Author:
    def __init__(self):
        self.first = "{}"
        self.last  = ""
        self.email = ""
        return

    def __str__(self):
        return self.first + " " + self.last

class Paper:
    def __init__(self):
        self.id       = 0
        self.short    = "" # short paper title
        self.long     = "" # long  paper title
        self.authors  = []
        self.session  = None
        self.abstract = ""
        return

    def __init__(self, fname):
        f = codecs.open(fname, encoding='utf-8')
        self.authors  = []
        #self.abstract = ""
        for line in f:
            line = line.strip()
            x = line.split('#=%=#')
            if len(x) != 2: x = line.split('#==#')
            #print x
            if len(x) != 2: continue
            (key,val) = x
            if key == "SubmissionNumber":
                self.id = val
            elif key == "FinalPaperTitle":
                self.long = val
            elif key == "ShortPaperTitle":
                self.short = val
            elif key[-9:-1] == "Lastname" and val != "":
                self.authors.append(Author())
                self.authors[-1].last = val
            elif key[-10:-1] == "Firstname" and val != "":
                self.authors[-1].first = val
            elif key[-6:-1] == "Email" and val != "":
                self.authors[-1].email = val
                pass
            elif key == "Abstract":
                #print "ABSTRACT:", val
                self.abstract = val 
                break
            pass
        for line in f:
            if line.strip() == "==========": break
            self.abstract += " " + line

        # Certain UTF-8 characters should be replaced by latex code
        # or latex will complain bitterly.
        self.abstract = self.abstract.replace(u"“",u"``")
        self.abstract = self.abstract.replace(u"”",u"''")
        self.abstract = self.abstract.replace(u' "',u" ``")
        self.abstract = self.abstract.replace(u'"',u"''")
        self.abstract = self.abstract.replace(u'ﬁ',u"fi")
        self.abstract = self.abstract.replace(u'ﬂ',u"fl")
        self.abstract = self.abstract.replace(u'’',u"'")
        self.abstract = self.abstract.replace(u'–',u"---")
        self.abstract = self.abstract.replace(u'&',u"\\&")
        self.abstract = self.abstract.replace(u'#',u"\\#")
        self.abstract = self.abstract.replace(u'_',u"\\_")
        
        return

    def __str__(self):
        return ", ".join([str(a) for a in self.authors]) + \
               ": \"" + self.long + "\""

    
