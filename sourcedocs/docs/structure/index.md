# Questionnaire Structure

> IMG

## First level - Questionnaire template

A questionnaire template is the sequencing of modules. It also includes the questionnaire logic (including filtering) and coherence controls. A questionnaire template is a survey instrument related to a specific thematic issue.

Questionnaire means that a questionnaire template is customised at the surveyed unit level. It is a concrete human-readable (interviewer or interviewee) representation of the questionnaire shown to a respondent. It can be either the prefilling of the principal activity of a business or the number of employees already known by the statistical institute in the case of a business survey.

### Template in DDI

The box below lists the DDI elements which describe a questionnaire template:

- The StudyUnit is the top element representing a statistical operation and one to many DataCollection is associated with a data collection campaign.
- Each DataCollection elements contains information on the data collection activities during a data collection campaign among which are the survey instruments. It contains a reference to the survey instrument component banks stored in the resource packages:
  - A reference to a question bank used by the survey instrument(s) (DDI QuestionScheme);
  - A reference to a control construct bank (DDI ControlConstructScheme);
  - A reference to a statement bank (DDI InterviewerInstructionScheme).
  - An instrument bank (DDI InstrumentScheme), where each instrument contains a reference to a main sequence (“level 0”) which is type a “template”.

!!! question "Updating this documentation"

    Check this weird XML sample

```xml
<s:StudyUnit xmlns="ddi:studyunit:3_3" >
    <d:DataCollection> 
        <r:QuestionSchemeReference/>
        <r:ControlConstructSchemeReference/>
        <r:InterviewerInstructionSchemeReference/>
            <d:InstrumentScheme xml:lang="en-IE”>
                <d:Instrument>
                    <d:InstrumentName>
                        <r:String>M1</r:String>
                    </d:InstrumentName>
                    <r:Label>
                        <r:Content xml:lang="en-IE">Simpsons survey</r:Content>
                    </r:Label>
                    <d:TypeOfInstrument>XForms</d:TypeOfInstrument>
                        <d:ControlConstructReference>
                        <r:Agency>fr.insee</r:Agency>
                        <r:ID>Sequence-jejocm31</r:ID>
                        <r:Version>1</r:Version>
                        <r:TypeOfObject>Sequence</r:TypeOfObject>
                    </d:ControlConstructReference>
            </d:Instrument>
    </d:InstrumentScheme>
```

## Second level : module

A __module__ is a level-“1”-of-depth sequence. It is a sub-theme of the thematic issue. A module is made of a title and can contain the sequencing of sub-modules. For instance the Business Outlook Survey among households distinguishes the module « Business Outlook » from the module « sociodemographic », etc.

### Module in DDI

A __module__ is represented by a DDI sequence, which references one or more constructs.
It is characterised as a module through an element Type of Sequence (TypeOfSequence) which takes the value « __Module__ » from a controlled vocabulary[^1] (a codelist) delimiting the range of values allowed for describing the business parts of the questionnaire. This process is known as typing the sequence. The title of the module is the sequence label.

```xml
<d:Sequence>
    <r:Label>
        <r:Content xml:lang="en-IE">Business Outlook</r:Content> 
    </r:Label> 
    <d:TypeOfSequence controlledVocabularyID="INSEE-TOS-CL-1">module</d:TypeOfSequence>
    <d:ControlConstructReference>
```

## Third level : sub-module

A __sub-module__ breaks down a module into a title and a sequencing of statements and questions. It is the finest semantic grouping of statements and questions.

### Sub-module in DDI

```xml
<d:Sequence>
    <d:TypeOfSequence codeListID="INSEE-TOS-CL-1">submodule</d:TypeOfSequence>
    <d:ControlConstructReference>
```

[^1]: Still to be implemented
