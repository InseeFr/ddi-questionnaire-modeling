# Questionnaire modeling in DDI

!!! info "Status of this documentation"

    This documentation is reporting the use of DDI for questionnaires at Insee and has for source material the "DDI Questionnaire Modelling" document by Dubois, Duffes and Bulot (2014-2019).

!!! question "Updating this documentation"

    Since the source material may not be always up to date with how we use the standard or how we implement questionnaires, those `question` blocks are here to mark when revisions or changes are needed.

The questionnaire metamodel is comprised of description of the metadata necessary for constituting the questionnaire template: questions, variables, code lists, statements (instructions, help, comments, warnings) as well as the statement and question grouping and flow (question blocks), filtering and controls. This description will be based on the XML DDI (Data Description Initiative) metamodel in it current version of use.

It is assumed below that all the XML-based DDI objects are identifiable, maintainable and versionable under the guise of a mandatory triple as follows (example):

```xml
<r:Agency>fr.insee</r:Agency>
<r:ID>INSEE-SIMPSONS-SU</r:ID>
<r:Version>1</r:Version>
```

In order to reduce the verbosity of the XML code which could impair its readability, the above-mentioned triple is not repeated in the following examples, it is implicit.

Furthermore the XML chunks used in the examples, taken individually, are not syntactically valid and are for illustrative purposes only.

_This document is a guide to good practices for modelling statistical questionnaires using DDI. The point is to make explicit the top (or mid)-level business object representation in DDI constituting a questionnaire. It does not give any detail on the DDI objects used, information provided by a DDI profile, to which the reader could refer if necessary._
