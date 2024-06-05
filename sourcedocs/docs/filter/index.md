# Filter

A filter question is a particular type of question in a questionnaire. Its purpose is to target a segment of the statistical population and drive it to specific branches of the questionnaire tree taking into account the responses provided previously (e.g. if yes, go to question 6, if no, go to question 9).

## Generic model

It is divided into three parts:

- The sequence which references the condition (IfThenElse) the same way as the other subsequences. The “target” sequence which is monitored by the filter can be of a different nature, specified by the element TypeOfIfThenElse attached to the IfThenElse:
  - « Hideable » , i.e not displayed on the screen, called « dynamic filter» (use case 1) ;
        It should be noted that an algorithmic choice for optimising the size of the XML tree and being compliant with the XForms output standard was done. The condition that defines the filter is always the one that validates the path via the next contiguous sequence. The non-validation of this condition does not trigger any specific behaviour apart from the display of the sequence defined after the condition construct (IfThenElse), which is from a business point of view the target sequence when the condition is met. For instance if a filtering condition is met which skips from the sequence 4 to the sequence 8, the opposite condition shall be defined. We then end up with SEQ-4, ITE-4, SEQ-8 with ITE-4 leading to the series of sequences SEQ-5, SEQ-6, SEQ-7 if the condition is met and does not trigger anything otherwise, and not SEQ-4, ITE-4, SEQ-9 with ITE-4 which displays SEQ-8 if the condition is true; SEQ-5, SEQ-6, SEQ-7 and SEQ-8 otherwise. Another example is given below.
  - « Greyed out », i.e. that has become deactivated and greyed out, called « greyed out filter » (use case 2) ;
- The condition that defines the filter is expressed through a construct IfThenElse (see below). Usually parameters from previous questions are reused.
- The constructs that reference the questions either in the sequences targeted in the condition (IfThenElse), or directly in the top-level sequence (the one that references the IfThenElse).
- Please note that an item <d:ExternalAid> can be added to a question so that routing instructions are made explicit in a PDF form (e.g. “If no, please go to question 4”).

### Simple example: « Hideable »

```xml
<d:Sequence>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-SEQ-14</r:ID>
    <r:Version>1</r:Version>
    <r:Label>
        <r:Content xml:lang="en-IE">
            <xhtml:p>Knowledge on the characters</xhtml:p>
        </r:Content>
    </r:Label>
    <d:InterviewerInstructionReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-IC-12-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Instruction</r:TypeOfObject>
    </d:InterviewerInstructionReference>
    <d:TypeOfSequence codeListID="INSEE-TOS-CL-1">Submodule</d:TypeOfSequence>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QC-14-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>QuestionConstruct</r:TypeOfObject>
    </d:ControlConstructReference>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-ITE-14-2</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>IfThenElse</r:TypeOfObject>
    </d:ControlConstructReference>
</d:Sequence>
<d:QuestionConstruct>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-QC-14-1</r:ID>
    <r:Version>1</r:Version>
    <r:QuestionReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QI-14-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>QuestionItem</r:TypeOfObject>
    </r:QuestionReference>
</d:QuestionConstruct>
<d:IfThenElse>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-ITE-14-2</r:ID>
    <r:Version>1</r:Version>
    <d:TypeOfIfThenElse controlledVocabularyID="INSEE-TOITE-CL-1">greyedout</d:TypeOfIfThenElse>
    <d:IfCondition>
        <r:Command>
            <r:ProgramLanguage>Neutral</r:ProgramLanguage>
            <r:InParameter isArray="true">
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS-ITEIP-14-1</r:ID>
                <r:Version>1</r:Version>
                <r:ParameterName>
                    <r:String xml:lang="en-IE">CHOMPART</r:String>
                </r:ParameterName>
                <r:NumericRepresentation></r:NumericRepresentation>
            </r:InParameter>
            <r:Binding>
                <r:SourceParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-QIOP-14-1</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>OutParameter</r:TypeOfObject>
                </r:SourceParameterReference>
                <r:TargetParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-ITEIP-14-1</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>InParameter</r:TypeOfObject>
                </r:TargetParameterReference>
            </r:Binding>
            <r:CommandContent>INSEE-SIMPSONS-ITEIP-14-1='O'</r:CommandContent>
        </r:Command>
    </d:IfCondition>
    <d:ThenConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-SEQ-14-2</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Sequence</r:TypeOfObject>
    </d:ThenConstructReference>
</d:IfThenElse>
<d:Sequence>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-SEQ-14-2</r:ID>
    <r:Version>1</r:Version>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QC-14-2</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>QuestionConstruct</r:TypeOfObject>
    </d:ControlConstructReference>
</d:Sequence>
<d:QuestionConstruct>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-QC-14-2</r:ID>
    <r:Version>1</r:Version>
    <r:QuestionReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QI-14-2</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>QuestionItem</r:TypeOfObject>
    </r:QuestionReference>
</d:QuestionConstruct>
```

### Complex example « Hideable »

> The detailed version of the sequences 32, 33, 34, 35, 36 et 37 is not provided for XML verbosity purposes.

```xml
<d:Sequence>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-SEQ-3234</r:ID>
    <r:Version>1</r:Version>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-SEQ-35</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Sequence</r:TypeOfObject>
    </d:ControlConstructReference>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-SEQ-36</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Sequence</r:TypeOfObject>
    </d:ControlConstructReference>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>IINSEE-SIMPSONS -SEQ-37</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Sequence</r:TypeOfObject>
    </d:ControlConstructReference>
</d:Sequence>
<d:IfThenElse>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-ITE-3</r:ID>
    <r:Version>1</r:Version>
    <d:TypeOfIfThenElse controlledVocabularyID="INSEE-TOITE-CL-2">hideable</d:TypeOfIfThenElse>
    <d:IfCondition>
        <r:Command>
            <r:ProgramLanguage>Neutral</r:ProgramLanguage>
            <r:InParameter isArray="true">
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS ITEIP-31</r:ID>
                <r:Version>1</r:Version>
                <r:ParameterName>
                    <r:String xml:lang="en-IE">Condition31ITE</r:String>
                </r:ParameterName>
                <r:CodeRepresentation>
                    <r:CodeListReference>
                        <r:Agency>fr.insee</r:Agency>
                        <r:ID>INSEE-SIMPSONS-CL-31</r:ID>
                        <r:Version>1</r:Version>
                        <r:TypeOfObject>CodeList</r:TypeOfObject>
                    </r:CodeListReference>
                </r:CodeRepresentation>
            </r:InParameter>
            <r:Binding>
                <r:SourceParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-QGOP-31</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>OutParameter</r:TypeOfObject>
                </r:SourceParameterReference>
                <r:TargetParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-ITEIP-31</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>InParameter</r:TypeOfObject>
                </r:TargetParameterReference>
            </r:Binding>
            <r:CommandContent>if Condition31ITE = 1,</r:CommandContent>
        </r:Command>
    </d:IfCondition>
    <d:ThenConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-SEQ-3234</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Sequence</r:TypeOfObject>
    </d:ThenConstructReference>
</d:IfThenElse>
<d:ElseIf>
    <d:IfCondition>
        <r:Command>
            <r:ProgramLanguage>Neutral</r:ProgramLanguage>
            <r:InParameter isArray="true">
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS -ITEIP-31</r:ID>
                <r:Version>1</r:Version>
                <r:ParameterName>
                    <r:String xml:lang="en-IE">Condition31ITE</r:String>
                </r:ParameterName>
                <r:CodeRepresentation>
                    <r:CodeListReference>
                        <r:Agency>fr.insee</r:Agency>
                        <r:ID>INSEE-SIMPSONS-CL-31</r:ID>
                        <r:Version>1</r:Version>
                        <r:TypeOfObject>CodeList</r:TypeOfObject>
                    </r:CodeListReference>
                </r:CodeRepresentation>
            </r:InParameter>
            <r:Binding>
                <r:SourceParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-QGOP-31</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>OutParameter</r:TypeOfObject>
                </r:SourceParameterReference>
                <r:TargetParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-ITEIP-31</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>InParameter</r:TypeOfObject>
                </r:TargetParameterReference>
            </r:Binding>
            <r:CommandContent>if Condition31ITE = 2</r:CommandContent>
        </r:Command>
    </d:IfCondition>
    <d:ThenConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-SEQ-3256</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Sequence</r:TypeOfObject>
    </d:ThenConstructReference>
</d:ElseIf>
```

In this example three choices (see below) are proposed to the respondent, each of them determines a specific path of the questionnaire tree.

The first two choices lead to specific questionnaire branches that are not contiguous to the main current branch. The DDI elements “If” and “ElseIf” together with a “Then” which allow to specify the sequence to which the respondent should be directed.

The third choice is the default behaviour, i.e. the main branch if the first two conditions (choices 1 and 2) are not met. In this precise use case we simply move on and reach the next contiguous sequence (that is sequence 4).

If an instruction must appear in the PDF file generated from the DDI specification, an ExternalAid should be added to the end of the question.

!!! question "Updating this documentation"

    XHTML reference, still relevant? :point_down:

```xml
<d:ExternalAid>
    <r:OtherMaterial>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-ECMOSS2017-OM-4-3-5-1</r:ID>
        <r:Version>1</r:Version>
        <r:Description>
            <r:Content>
                <xhtml:div class="FlowControl" id="INSEE-ECMOSS2017-ITE-0">
                    <xhtml:div class="Description">If you answer “no”, then proceed to question 5</xhtml:div>
                    <xhtml:div class="Expression">$READY$ != '1'</xhtml:div>
                    <xhtml:div class="IfTrue">j6z12s2d</xhtml:div>
                </xhtml:div>
            </r:Content>
        </r:Description>
    </r:OtherMaterial>
</d:ExternalAid>
```

### Example: « Greyed out »

<!-- markdownlint-disable MD051 -->
The DDI is the same as the previous use case [Simple example « Hideable »](#simple-example-hideable) where « Greyed out » is the value of the sequence type instead of « Hideable ».

## Graphical representation

!!! question "Updating this documentation"

    Once again, what kind of representation.

In the Web questionnaire, the dynamic filter makes appear/disappear dynamically one or more questions. This choice of ergonomics allows notably to make the questionnaire more readable to the respondents.

The representation associated with the DDI modelling is as follows:

Do you know Kent Brockman⇒ ?

If the answer is “Yes”, then the following question is displayed:

Can you mention his best⇒ coverages?

### Complex example: « Hideable »

This example is not feasible in this document for verbosity sake. However to give a broad idea on it an example would be to jump from a Web page N to a Web page N+4.

### Example « Greyed out »

In the Web questionnaire, the greyed out filter locks/unlocks one or more questions. Although the question is visible, the respondent could answer it only if the respondent gives the responses that allow to unlock the question(s).

The representation associated with the DDI modelling (“Greyed out” is the type of sequence) is as follows:

Do you know Kent Brockman⇒ ?

If the answer to the question is « Yes », then the question below is unlocked:

Can you mention his best⇒ coverages
