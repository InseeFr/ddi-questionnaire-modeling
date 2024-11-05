# _Roundabout_ loops

A _roundabout_ is a special kind of loop that contains a menu, on which the respondents can navigate between occurrences.

The logic is the same as a linked loop.

The chosen DDI modeling for a roundabout uses a `Sequence` object, that references a `Loop`.

Example of a questionnaire containing a roundabout:

```xml
<DDIInstance>
  <g:ResourcePackage>

    <d:InterviewerInstructionScheme>
      <!-- Label of the roundabout occurrences -->
      <d:Instruction>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence-OL</r:ID>
        <r:Version>1</r:Version>
        <!-- Metadata to mark the label as a loop occurrence label -->
        <d:InstructionName>
          <r:String xml:lang="fr-FR">loop.instanceLabel</r:String>
        </d:InstructionName>
        <!-- In this example: dynamic label with the variable "first name" -->
        <d:InstructionText>
          <d:LiteralText>
            <d:Text xml:lang="fr-FR">¤id-first-name-question-QOP-reference-first-name-variable¤</d:Text>
          </d:LiteralText>
          <d:ConditionalText>
            <r:SourceParameterReference>
              <r:Agency>fr.insee</r:Agency>
              <r:ID>id-first-name-question-QOP-reference-first-name-variable</r:ID>
              <r:Version>1</r:Version>
              <r:TypeOfObject>OutParameter</r:TypeOfObject>
            </r:SourceParameterReference>
          </d:ConditionalText>
        </d:InstructionText>
      </d:Instruction>
      <!-- Description of the roundabout occurrences -->
      <d:Instruction>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence-OD</r:ID>
        <r:Version>1</r:Version>
        <d:InstructionName>
          <r:String xml:lang="fr-FR">loop.instanceDescription</r:String>
        </d:InstructionName>
        <d:InstructionText>
          <d:LiteralText>
            <d:Text xml:lang="fr-FR">"Occurrence description of " || ¤id-first-name-question-QOP-reference-first-name-variable¤ </d:Text>
          </d:LiteralText>
          <d:ConditionalText>
            <r:SourceParameterReference>
              <r:Agency>fr.insee</r:Agency>
              <r:ID>id-first-name-question-QOP-reference-first-name-variable</r:ID>
              <r:Version>1</r:Version>
              <r:TypeOfObject>OutParameter</r:TypeOfObject>
            </r:SourceParameterReference>
          </d:ConditionalText>
        </d:InstructionText>
      </d:Instruction>
    </d:InterviewerInstructionScheme>

    <d:ControlConstructScheme>

      <d:Sequence>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>abcd1234</r:ID>
        <r:Version>1</r:Version>
        <!-- ... (sequence content) -->
      </d:Sequence>

      <!-- Sequence object that describes the roundabout -->
      <d:Sequence>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence</r:ID>
        <r:Version>1</r:Version>
        <r:Label>
          <r:Content xml:lang="fr-FR">Roundabout global label</r:Content>
        </r:Label>
        <!-- Reference for the label of the roundabout occurrences -->
        <d:InterviewerInstructionReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-roundabout-sequence-OL</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>Instruction</r:TypeOfObject>
        </d:InterviewerInstructionReference>
        <!-- Reference for the description of the roundabout occurrences -->
        <d:InterviewerInstructionReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-roundabout-sequence-OL</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>Instruction</r:TypeOfObject>
        </d:InterviewerInstructionReference>
        <!-- Metadata that marks the sequence as a roundabout sequence -->
        <d:TypeOfSequence controlledVocabularyID="INSEE-TOS-CL-1">roundabout</d:TypeOfSequence>
        <!-- Reference for the roundabout loop -->
        <d:ControlConstructReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-roundabout-sequence-ROUNDABOUT_LOOP_NAME</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>Loop</r:TypeOfObject>
        </d:ControlConstructReference>
        <!-- Reference of the control which describes whether the responses of an occurrence are locked after response -->
        <!-- NB: in the absence of this control, the answers are not locked -->
        <d:ControlConstructReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-roundabout-sequence-LOCK</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>ComputationItem</r:TypeOfObject>
        </d:ControlConstructReference>
      </d:Sequence>

      <!-- Control which describes whether the responses of an occurrence are locked after response -->
      <d:ComputationItem>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence-LOCK</r:ID>
        <r:Version>1</r:Version>
        <!-- Metadata that marks this special type of control -->
        <d:TypeOfComputationItem controlledVocabularyID="INSEE-TOCI-CL-9">roundabout-locked</d:TypeOfComputationItem>
        <!-- Condition for locking occurrences -->
        <r:CommandCode>
          <r:Command>
            <r:ProgramLanguage>VTL</r:ProgramLanguage>
            <r:CommandContent>true</r:CommandContent>
          </r:Command>
        </r:CommandCode>
      </d:ComputationItem>

      <!-- Roundabout loop -->
      <d:Loop>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence-ROUNDABOUT_LOOP_NAME</r:ID>
        <r:Version>1</r:Version>
        <d:ConstructName>
          <r:String xml:lang="fr-FR">ROUNDABOUT_LOOP_NAME</r:String>
        </d:ConstructName>
        <d:ControlConstructReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-roundabout-sequence-ROUNDABOUT_LOOP_NAME-SEQ</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>Sequence</r:TypeOfObject>
        </d:ControlConstructReference>
      </d:Loop>

      <!-- Sequence of the roundabout loop -->
      <d:Sequence>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence-ROUNDABOUT_LOOP_NAME-SEQ</r:ID>
        <r:Version>1</r:Version>
        <!-- Metadata that marks the sequence as a loop sequence -->
        <d:TypeOfSequence controlledVocabularyID="INSEE-TOS-CL-1">loopContent</d:TypeOfSequence>
        <!-- References of the elements to which the loop applies -->
        <d:ControlConstructReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>abcd1234</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>Sequence</r:TypeOfObject>
        </d:ControlConstructReference>
        <!-- ... (other elements included in the loop) -->
      </d:Sequence>

    </d:ControlConstructScheme>

    <l:VariableScheme>
      <!-- First name variable -->
      <l:Variable>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-first-name-variable</r:ID>
        <r:Version>1</r:Version>
        <l:VariableName>
          <r:String xml:lang="fr-FR">FIRST_NAME</r:String>
        </l:VariableName>
        <r:Label>
          <r:Content xml:lang="fr-FR">FIRST_NAME label</r:Content>
        </r:Label>
        <r:SourceParameterReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-first-name-question-QOP-reference-first-name-variable</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:SourceParameterReference>
        <r:QuestionReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-first-name-question</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>QuestionItem</r:TypeOfObject>
        </r:QuestionReference>
        <l:VariableRepresentation>
          <r:TextRepresentation maxLength="50"/>
        </l:VariableRepresentation>
      </l:Variable>
    </l:VariableScheme>

  </g:ResourcePackage>
</DDIInstance>
```

## Controls in a roundabout

Two kinds of controls can be applied to a roundabout: _roundabout_ level controls that are designed to check the validity of responses at the loop scope, and _occurrences_ level controls that are designed to be applied on the loop occurrences.

Roundabout-level controls are referenced in the roundabout main sequence object.

Occurrences-level controls are referenced in the roundabout loop sequence.

Example of a questionnaire containing a roundabout, with a roundabout-level control, and a occurrence-level control:

```xml
<DDIInstance>
  <g:ResourcePackage>

    <d:ControlConstructScheme>

      <d:Sequence>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>abcd1234</r:ID>
        <r:Version>1</r:Version>
        <!-- ... (sequence content) -->
      </d:Sequence>

      <!-- Sequence object that describes the roundabout -->
      <d:Sequence>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence</r:ID>
        <r:Version>1</r:Version>
        <!-- ... (roundabout metadata) -->
        <!-- Reference for the roundabout loop -->
        <d:ControlConstructReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-roundabout-sequence-ROUNDABOUT_LOOP_NAME</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>Loop</r:TypeOfObject>
        </d:ControlConstructReference>
        <!-- ... (optional control that describes the locking of occurrences) -->
        <!-- Reference for a roundabout level control -->
        <d:ControlConstructReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-roundabout-sequence-CI-0</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>ComputationItem</r:TypeOfObject>
        </d:ControlConstructReference>
      </d:Sequence>

      <!-- Roundabout loop -->
      <d:Loop>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence-ROUNDABOUT_LOOP_NAME</r:ID>
        <r:Version>1</r:Version>
        <d:ConstructName>
          <r:String xml:lang="fr-FR">ROUNDABOUT_LOOP_NAME</r:String>
        </d:ConstructName>
        <d:ControlConstructReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-roundabout-sequence-ROUNDABOUT_LOOP_NAME-SEQ</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>Sequence</r:TypeOfObject>
        </d:ControlConstructReference>
      </d:Loop>

      <!-- Sequence of the roundabout loop -->
      <d:Sequence>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence-ROUNDABOUT_LOOP_NAME-SEQ</r:ID>
        <r:Version>1</r:Version>
        <!-- Metadata that marks the sequence as a loop sequence -->
        <d:TypeOfSequence controlledVocabularyID="INSEE-TOS-CL-1">loopContent</d:TypeOfSequence>
        <!-- References of the elements to which the loop applies -->
        <d:ControlConstructReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>abcd1234</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>Sequence</r:TypeOfObject>
        </d:ControlConstructReference>
        <!-- ... (other elements included in the loop) -->
        <!-- Reference for a control over occurrences of the roundabout loop -->
        <d:ControlConstructReference>
          <r:Agency>fr.insee</r:Agency>
          <r:ID>id-roundabout-sequence-CI-1</r:ID>
          <r:Version>1</r:Version>
          <r:TypeOfObject>ComputationItem</r:TypeOfObject>
        </d:ControlConstructReference>
      </d:Sequence>

      <!-- Roundabout level control -->
      <!-- i.e. control to be displayed on the roundabout menu -->
      <d:ComputationItem>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence-CI-0</r:ID>
        <r:Version>1</r:Version>
        <!-- ... (control content) -->
      </d:ComputationItem>

      <!-- Control over occurrences of the roundabout loop -->
      <d:ComputationItem>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-roundabout-sequence-CI-1</r:ID>
        <r:Version>1</r:Version>
        <!-- ... (control content) -->
      </d:ComputationItem>

    </d:ControlConstructScheme>

  </g:ResourcePackage>
</DDIInstance>
```
