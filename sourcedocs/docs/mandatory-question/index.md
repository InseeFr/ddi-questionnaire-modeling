# Mandatory question

A question can be marked as _mandatory_.

## Single response question

Questions that have a single response are `d:QuestionItem` objects.

Such questions are marked as _mandatory_ if the tag `<r:ResponseCardinality minimumResponses="1"/>` is present.

Example:

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

---

## Namespaces

```xml
<DDIInstance xmlns="ddi:instance:3_3"
             xmlns:d="ddi:datacollection:3_3"
             xmlns:g="ddi:group:3_3"
             xmlns:r="ddi:reusable:3_3"
             xsi:schemaLocation="ddi:instance:3_3 https://www.ddialliance.org/Specification/DDI-Lifecycle/3.3/XMLSchema/instance.xsd">
```
