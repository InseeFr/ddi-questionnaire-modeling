# Unique choice question

## Code list-based unique choice question

A regular unique choice question has its options defined by a code list.

It is associated with a single variable.

The response is a text domain.

In a web interviewing tool, the options can be inputted in different formats. This is determined by the tag `<r:GenericOutputFormat controlledVocabularyID="INSEE-GOF-CV">`, with values:

- `radio-button`: radio buttons
- `drop-down-list`: dropdown list
- `suggester`: suggester field

See [questions documentation](./index.md) for other details.

## Suggester unique choice question

For unique choice questions where the response field is a text field with auto-completion (suggester), the code list referenced in the question can be a reference to an external (potentially long) nomenclature.

## Variable based unique choice question

A unique choice question can have its options defined by a variable (collected, calculated or external).

Example:

> Who's the best Mario Kart player?
> - ( ) Alex
> - ( ) Sam
> - ( ) Jordan

where options are responses on a text question "What's your name?" (variable "`NAME`") defined in an interation.

```xml
<d:QuestionItem>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>ucq-id</r:ID>
    <r:Version>1</r:Version>
    <d:QuestionItemName>
        <r:String xml:lang="fr-FR">UCQ_VARIABLE</r:String>
    </d:QuestionItemName>
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>ucq-id-QOP-param-id</r:ID>
        <r:Version>1</r:Version>
        <r:ParameterName>
            <r:String xml:lang="fr-FR">UCQ_VARIABLE</r:String>
        </r:ParameterName>
    </r:OutParameter>
    <r:Binding>
        <r:SourceParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>ucq-id-RDOP-param-id</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:SourceParameterReference>
        <r:TargetParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>ucq-id-QOP-param-id</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:TargetParameterReference>
    </r:Binding>
    <d:QuestionText>
        <d:LiteralText>
            <d:Text xml:lang="fr-FR">"Who's the best Mario Kart player?"</d:Text>
        </d:LiteralText>
    </d:QuestionText>
    <d:CodeDomain>
        <r:GenericOutputFormat controlledVocabularyID="INSEE-GOF-CV">radio-button</r:GenericOutputFormat>
        <r:CodeListReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>name-variable-id-CL</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>CodeList</r:TypeOfObject>
        </r:CodeListReference>
        <r:OutParameter isArray="false">
            <r:Agency>fr.insee</r:Agency>
            <r:ID>ucq-id-RDOP-param-id</r:ID>
            <r:Version>1</r:Version>
            <r:CodeRepresentation>
                <r:CodeListReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>name-variable-id-CL</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>CodeList</r:TypeOfObject>
                </r:CodeListReference>
            </r:CodeRepresentation>
        </r:OutParameter>
        <r:ResponseCardinality maximumResponses="1"/>
    </d:CodeDomain>
</d:QuestionItem>
```

With variable:

```xml
<l:Variable>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>name-variable-id</r:ID>
    <r:Version>1</r:Version>
    <l:VariableName>
        <r:String xml:lang="fr-FR">NAME</r:String>
    </l:VariableName>
    <r:Label>
        <r:Content xml:lang="fr-FR">NAME label </r:Content>
    </r:Label>
    <r:SourceParameterReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>name-question-id-QOP-name-param-id</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>OutParameter</r:TypeOfObject>
    </r:SourceParameterReference>
    <r:QuestionReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>name-question-id</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>QuestionItem</r:TypeOfObject>
    </r:QuestionReference>
    <l:VariableRepresentation>
        <r:TextRepresentation maxLength="50"/>
    </l:VariableRepresentation>
</l:Variable>
```

this variable being in the scope of an iteration (e.g. a `<d:Loop>`).

With pseudo-code list:

```xml
<l:CodeList>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>name-variable-id-CL</r:ID>
    <r:Version>1</r:Version>
    <r:Label>
        <r:Content xml:lang="fr-FR">List based on NAME values.</r:Content>
    </r:Label>
    <l:HierarchyType>Regular</l:HierarchyType>
    <l:Level levelNumber="1">
        <l:CategoryRelationship>Ordinal</l:CategoryRelationship>
    </l:Level>
    <r:BasedOnObject>
        <r:BasedOnReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>name-variable-id</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>Variable</r:TypeOfObject>
        </r:BasedOnReference>
    </r:BasedOnObject>
</l:CodeList>
```
