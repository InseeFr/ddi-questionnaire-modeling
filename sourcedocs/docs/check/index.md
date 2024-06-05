# Check

The web questionnaire allows to operate online checks and then raise the response quality. There are two types of checks: the data entry checks and the micro-checks (e.g. the coherence checks).

## Data entry check

The input check is linked to the response domain, e.g. checking the data type of a response input. A very same data entry check will be applied to any identical response domain. Thus the check per se is not made explicit (apart from the regular expressions), it is simply embedded in the response domain. These checks do not trigger any DDI tailor-made error message or require any level of criticality.

Example:

- text field up to 200 characters maximum
- integer up to 3 digits between 0 and 100
- date format DDMMYYYY, etc.

An example checking the length of a string:

```xml
<d:TextDomain maxLength="200"> </d:TextDomain>
```

A check on a numeric field:

```xml
<d:NumericDomain>
    <r:NumberRange>
        <r:Low>0</r:Low>
        <r:High>99999999</r:High>
    </r:NumberRange>
    <r:NumericTypeCode codeListID="INSEE-SIMPSONS-NTC-CV">Integer</r:NumericTypeCode>
</d:NumericDomain>
```

A check on a date field:

```xml
<r:DateTimeDomain regExp="\d{3}\-\d{2}\-\d{4}">
    <r:DateTypeCode>date</r:DateTypeCode>
</r:DateTimeDomain>
```

## Microcheck

There are currently three types of microchecks :

- the internal coherence checks;
- the internal likelihood-ratio checks (the comparison of a ratio with its distribution) ;
- Temporal likelihood-ratio checks (ditto but using the ratio N/N-1).

A microcheck is defined by:

- a check condition;
- a DDI error message displayed if the condition is met;
- a criticality level.

The coherence checks are represented by the `<ComputationItem>` which are constructs per se. The condition within the command determines whether or not the messages be displayed (such as statements typed as warning).

The input values to the check are brought by and stored within the parameters.

It should be noted that it is now possible in DDI 3.3 to specify a criticality level for the check by typing the `<ComputationItem>` (item TypeOfComputationItem).

Its value range is still to be validated internally, and will be serialised as an external controlled vocabulary: at least “stumbling block” and “warning” will be in that code list.

!!! question "Updating this documentation"

    The old text was "It should be also noted that a work in progress at Insee aims to define a check specification language. In this version of the document, the checks are expressed using the Xpath language."

Insee is using [VTL](https://sdmx.org/?page_id=5096) as the micro checks language.

```xml
<d:Sequence>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-SEQ-23</r:ID>
    <r:Version>1</r:Version>
    <r:Label>
        <r:Content xml:lang="en-IE">
            <xhtml:p>Shopping at the mini-market</xhtml:p>
        </r:Content>
    </r:Label>
    <d:TypeOfSequence codeListID="INSEE-TOS-CL-1">Submodule</d:TypeOfSequence>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QC-23-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>QuestionConstruct</r:TypeOfObject>
    </d:ControlConstructReference>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CI-23-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>ComputationItem</r:TypeOfObject>
    </d:ControlConstructReference>
</d:Sequence>
<d:QuestionConstruct>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-QC-23-1</r:ID>
    <r:Version>1</r:Version>
    <r:QuestionReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QI-23</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>QuestionItem</r:TypeOfObject>
    </r:QuestionReference>
</d:QuestionConstruct>
```

```xml
<d:ComputationItem>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-CI-23-1</r:ID>
    <r:Version>1</r:Version>
    <d:TypeOfComputationItem controlledVocabularyID="INSEE-TOCI-CL-1INSEE-TOCI-CL-1">stumblingblock</d:TypeOfComputationItem>
    <d:InterviewerInstructionReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-II-e</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Instruction</r:TypeOfObject>
    </d:InterviewerInstructionReference>
    <r:CommandCode>
        <r:Command>
            <r:ProgramLanguage>Neutral</r:ProgramLanguage>
            <r:InParameter isArray="true">
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS-CIIP-23-1</r:ID>
                <r:Version>1</r:Version>
                <r:ParameterName>
                    <r:String xml:lang="en-IE">icecream</r:String>
                </r:ParameterName>
            </r:InParameter>
[...]
            <r:InParameter isArray="true">
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS-CIIP-23-5</r:ID>
                <r:Version>1</r:Version>
                <r:ParameterName>
                    <r:String xml:lang="en-IE">TotalExpenses</r:String>
                </r:ParameterName>
            </r:InParameter>
            <r:Binding>
                <r:SourceParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-QIOP-23-1</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>OutParameter</r:TypeOfObject>
                </r:SourceParameterReference>
                <r:TargetParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-CIIP-23-1</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>InParameter</r:TypeOfObject>
                </r:TargetParameterReference>
            </r:Binding>
[...]
            <r:Binding>
                <r:SourceParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-QIOP-23-5</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>OutParameter</r:TypeOfObject>
                </r:SourceParameterReference>
                <r:TargetParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-CIIP-23-5</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>InParameter</r:TypeOfObject>
                </r:TargetParameterReference>
            </r:Binding>
            <r:CommandContent>INSEE-SIMPSONS-CIIP-23-5 = INSEE-SIMPSONS-CIIP-23-1 + INSEE-SIMPSONS-CIIP-23-2 + INSEE-SIMPSONS-CIIP-23-3 + INSEE-SIMPSONS-CIIP-23-4 </r:CommandContent>
        </r:Command>
    </r:CommandCode>
</d:ComputationItem>
```

If INSEE-SIMPSONS-CIIP-23-5 = INSEE-SIMPSONS-CIIP-23-1 + INSEE-SIMPSONS-CIIP-23-2 + INSEE-SIMPSONS-CIIP-23-3 + INSEE-SIMPSONS-CIIP-23-4, then the following message is displayed:

__The total expenses at the mini-market is different from the sum of the amounts claimed. Please correct it.__
