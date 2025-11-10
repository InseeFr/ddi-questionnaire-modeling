# Mandatory question

A question can be marked as _mandatory_.

## Single response question

Questions that have a single response are `d:QuestionItem` objects.

Such questions are marked as _mandatory_ if the element `<r:ResponseCardinality/>` is present with the attribute `minimumResponses="1"` in the _response domain_.

The _response domain_ is for instance:

- a `d:NominalDomain` object for a boolean question
- a `d:TextDomain` object for a text question
- a `d:NumericDomain` object for a numeric question
- a `d:CodeDomain` object for a unique choice question

Example (text question):

`DDIInstance > g:ResourcePackage > d:QuestionScheme`

```xml
<d:QuestionItem>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>question-item-id</r:ID>
    <r:Version>1</r:Version>
    <d:QuestionItemName>
        <r:String xml:lang="fr-FR">Q_MANDATORY</r:String>
    </d:QuestionItemName>
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>question-item-id-QOP-out-param-id</r:ID>
        <r:Version>1</r:Version>
        <r:ParameterName>
            <r:String xml:lang="fr-FR">Q_MANDATORY</r:String>
        </r:ParameterName>
    </r:OutParameter>
    <r:Binding>
        <r:SourceParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>question-item-id-RDOP-out-param-id</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:SourceParameterReference>
        <r:TargetParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>question-item-id-QOP-out-param-id</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:TargetParameterReference>
    </r:Binding>
    <d:QuestionText>
        <d:LiteralText>
            <d:Text xml:lang="fr-FR">"Mandatory question"</d:Text>
        </d:LiteralText>
    </d:QuestionText>
    <d:TextDomain maxLength="249">
        <r:OutParameter isArray="false">
            <r:Agency>fr.insee</r:Agency>
            <r:ID>question-item-id-RDOP-out-param-id</r:ID>
            <r:Version>1</r:Version>
            <r:TextRepresentation maxLength="249"/>
        </r:OutParameter>
        <r:ResponseCardinality minimumResponses="1"/>
    </d:TextDomain>
</d:QuestionItem>
```

!!! warning "Particular case"

The _response domain_ of a unique choice question that has an additional "details" text field is a `d:StructuredMixedResponseDomain` object.

In that case, the _mandatory_ metadata (`minimumResponses="1"`) is placed in the `d:CodeDomain` within one of the `d:ResponseDomainInMixed"`.

Example:

!!!

```xml
<d:QuestionItem>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>question-id</r:ID>
    <r:Version>1</r:Version>
    <!-- Question item name... -->
    <!-- Out parameters... -->
    <!-- Bindings... -->
    <!-- Question text... -->
    <d:StructuredMixedResponseDomain>
        <d:ResponseDomainInMixed attachmentBase="1">
            <d:CodeDomain>
                <r:GenericOutputFormat controlledVocabularyID="INSEE-GOF-CV">radio-button</r:GenericOutputFormat>
                <!-- Code list reference... -->
                <!-- Out parameter... -->
                <r:ResponseCardinality minimumResponses="1" maximumResponses="1"/>
            </d:CodeDomain>
        </d:ResponseDomainInMixed>
        <d:ResponseDomainInMixed>
            <d:TextDomain maxLength="249">
                <r:Label>
                    <r:Content xml:lang="fr-FR">"Please specify: "</r:Content>
                </r:Label>
                <!-- Out parameter... -->
            </d:TextDomain>
            <d:AttachmentLocation>
                <d:DomainSpecificValue attachmentDomain="1">
                    <r:Value><!-- Modality number --></r:Value>
                </d:DomainSpecificValue>
                <!-- Code reference... -->
            </d:AttachmentLocation>
        </d:ResponseDomainInMixed>
    </d:StructuredMixedResponseDomain>
</d:QuestionItem>
```

## Multiple response question

Questions that have multiple response (e.g. multiple choice question, tables, dynamic tables) are `d:QuestionGrid` objects.

The _response domain_ of a multiple response question is a `d:StructuredMixedGridResponseDomain` object.

This object has no property that could represent a response cardinality.

Then, for now, there is no modeling for the _mandatory_ nature of a multiple response question.

---

## Namespaces

```xml
<DDIInstance xmlns="ddi:instance:3_3"
             xmlns:d="ddi:datacollection:3_3"
             xmlns:g="ddi:group:3_3"
             xmlns:r="ddi:reusable:3_3"
             xsi:schemaLocation="ddi:instance:3_3 https://www.ddialliance.org/Specification/DDI-Lifecycle/3.3/XMLSchema/instance.xsd">
```
