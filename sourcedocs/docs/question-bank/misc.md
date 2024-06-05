# Miscellaneous

## Response domain

There are two types of DDI response domains:

- those added in-line like in the examples provided in this document;
- those that can be reused, defined in ad hoc structures, the « Managed*Representation » contained in a « ManagedRepresentationScheme ».

For the latter, the only response domain types available are the following:

- ManagedDateTimeRepresentation ;
- ManagedMissingValuesRepresentation ;
- ManagedNumericRepresentation ;
- ManagedScaleRepresentation ;
- ManagedTextRepresentation.

It should be noted that the numeric response domain can be subtyped through the <NumericTypeCode> element which takes meaning from an external controlled vocabulary.
Here is below an example of a ManagedNumericRepresentation referenced in a QuestionItem.

```xml
<r:ManagedRepresentationScheme>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-MRS</r:ID>
    <r:Version>1</r:Version>
    <r:ManagedNumericRepresentation>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-MNR-EFF</r:ID>
        <r:Version>1</r:Version>
        <r:NumberRange>
            <r:Low>1000</r:Low>
            <r:High>999999999</r:High>
        </r:NumberRange>
        <r:NumericTypeCode codeListID="INSEE-PIPA-NTC-CV">Integer</r:NumericTypeCode>
    </r:ManagedNumericRepresentation>
</r:ManagedRepresentationScheme>
<d:QuestionItem>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-QI-2-6</r:ID>
    <r:Version>1</r:Version>
    <d:QuestionText>
        <d:LiteralText>
            <d:Text>How many people work at the nuclear power plant?</d:Text>
        </d:LiteralText>
    </d:QuestionText>
    <d:NumericDomainReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-MNR-EFF</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>ManagedNumericRepresentation</r:TypeOfObject>
    </d:NumericDomainReference>
</d:QuestionItem>
```

### Graphical representation

Any of the response domains defined in the previous examples can be an illustration of the use of a Managed*Representation.

## NumericTypeCode

It should be noted that the numeric response domain can be subtyped through the `<NumericTypeCode>` element which takes meaning from an external controlled vocabulary.

```xml
<r:NumericTypeCode codeListID="INSEE-CIS-NTC-CV">Decimal</r:NumericTypeCode>
```

## Range

A range can be defined for both numeric and DateTime domain allowing to express minimum and maximum limits or start and end dates.

```xml
<d:DateTimeDomain>
    <r:DateFieldFormat>jj/mm/aaaa</r:DateFieldFormat>
    <r:DateTypeCode controlledVocabularyID="INSEE-DTC-CV">date</r:DateTypeCode>
    <r:Range>
        <r:MinimumValue included="true">10/09/2018</r:MinimumValue>
        <r:MaximumValue included="true">18/09/2018</r:MaximumValue>
    </r:Range>
</d:DateTimeDomain>
```

```xml
<d:NumericDomain>
    <r:NumberRange>
        <r:Low isInclusive="true">0</r:Low>
        <r:High isInclusive="true">99</r:High>
    </r:NumberRange>
    <r:NumericTypeCode codeListID="INSEE-CIS-NTC-CV">Decimal</r:NumericTypeCode>
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>j6q9h8tj-RDOP-jbgdjy8h</r:ID>
        <r:Version>1</r:Version>
    </r:OutParameter>
</d:NumericDomain>
```

## Mandatory response and limited number of choices

On one hand, a response can be specified as mandatory by adding `<r:ResponseCardinality minimumResponses="1"/>` in any response domain.

On the other hand, in a code domain only, a maximum number of responses can be specific using the maximumResponses attribute in `<ResponseCardinality>`.

```xml
<d:CodeDomain>
    <r:GenericOutputFormat codeListID="INSEE-GOF-CV">checkbox</r:GenericOutputFormat>
    <r:CodeListReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>jbdxricm</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>CodeList</r:TypeOfObject>
    </r:CodeListReference>
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>j6yzoc6g-RDOP-jvxx24wn</r:ID>
        <r:Version>1</r:Version>
        <r:CodeRepresentation>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>jbdxricm</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </r:CodeRepresentation>
    </r:OutParameter>
    <r:ResponseCardinality maximumResponses="1"/>
</d:CodeDomain>
```

## Conditional question

A conditional question is a question with a conditional text parametrised by the responses to one or more questions from the instrument.

The condition for displaying a text is expressed within a command contained in a <d:ConditionalText> element. DDI does not handle currently the link between a text to be displayed and its related condition: the assumption is made that the text expressed in the <d:LiteralText> follows its condition within the sequence of DDI elements[^1].

!!! question "Updating this documentation"

    Update with VTL code, but also document the direct use of VTL code for custom label?

```xml
<d:QuestionText>
    <d:ConditionalText>
        <d:Expression>
            <r:Command>
                <r:ProgramLanguage>xpath</r:ProgramLanguage>
                <r:CommandContent>if VAR=2</r:CommandContent>
            </r:Command>
        </d:Expression>
    </d:ConditionalText>
    <d:LiteralText>
        <d:Text>After his dismissal did Homer seek advice of any public body?</d:Text>
    </d:LiteralText>
    <d:ConditionalText>
        <d:Expression>
            <r:Command>
                <r:ProgramLanguage>xpath</r:ProgramLanguage>
                <r:CommandContent>if VAR=1 or VAR=3</r:CommandContent>
            </r:Command>
        </d:Expression>
    </d:ConditionalText>
    <d:LiteralText>
        <d:Text>After his dismissal did Homer get in touch with the Employment Agency?</d:Text>
    </d:LiteralText>
</d:QuestionText>
```

### Graphical representation

!!! question "Updating this documentation"

    Is it useful here?

If the variable VAR takes the value of 2 then the question text is as follows:

⇒After his dismissal did Homer seek advice of any public body?

If the variable VAR takes the value of 1 or 3, then the question text is as follows::

⇒After his dismissal did Homer get in touch with Employment Agency?

## Other material in a category

!!! question "Updating this documentation"

    Update for VTL and Markdown use.

The main use case is the addition of an image to a table row or column, e.g. an arrow that illustrate the evolution of a certain quantity: up, down or stable.

The r:OtherMaterial in the l:Generation from the l:Category attached to each code in the response domain is then used with a reference through a local path to a file on a server (e.g. Orbeon).

```xml
<l:Generation>
    <r:OtherMaterial>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-COMMUN-OM-hausse_stable_baisse-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfMaterial codeListID="INSEE-TOM-CV">image</r:TypeOfMaterial>
        <r:ExternalURLReference>en-hausse.jpg</r:ExternalURLReference>
    </r:OtherMaterial>
</l:Generation>
```

### Graphical representation

> TODO!

## Greyed out box in a grid

Some boxes in a question grid can be greyed out or empty for various reasons: either the intersection of two modalities does not make sense for the respondent, or the survey designer chose explicitly not to have this box fillable, or a fixed value is defined in it. The d:QuestionGrid offers a possibility to capture this.

The d:NoDataByDefinition in the d:StructuredMixedGridResponseDomain from the d:QuestionGrid can play the same role as the d:GridResponseDomainInMixed where the specification of the coordinates for the deactivated box are also requested.

```xml
<d:NoDataByDefinition>
    <d:CellCoordinatesAsDefined>
        <d:SelectDimension rank="1" specificValue="1"/>
        <d:SelectDimension rank="2" specificValue="1"/>
    </d:CellCoordinatesAsDefined>
</d:NoDataByDefinition>
```

If a fixed value is requested in the box, the d:FixedCellLabel should be used with the coordinates in the d:GridAttachment identical to the ones in the d:NoDataByDefinition and the value itself which is stored in the r:Value.

```xml
<d:FixedCellValue>
    <r:Value>Working Days</r:Value>
    <d:GridAttachment>
        <d:CellCoordinatesAsDefined>
            <d:SelectDimension rank="1" specificValue="1"/>
            <d:SelectDimension rank="2" rangeMinimum="2" rangeMaximum="2"/>
        </d:CellCoordinatesAsDefined>
    </d:GridAttachment>
</d:FixedCellValue>
```

If a label needs to be attached to the box, the d:CellLabel should be used with the coordinates in the d:GridAttachment identical to the ones in the d:NoDataByDefinition. The type of label should be set to “fixedcell”. The feature is more to used in PDF or paper form.

```xml
<d:CellLabel>
    <r:Content xml:lang="fr-FR">Working Days</r:Content>
    <r:TypeOfLabel specificValuecodeListID="INSEE-TOL-CV">fixedcell</r:TypeOfLabel>
    <d:GridAttachment>
        <d:CellCoordinatesAsDefined>
            <d:SelectDimension rank="1" specificValue="1"/>
            <d:SelectDimension rank="2" rangeMinimum="2" rangeMaximum="2"/>
        </d:CellCoordinatesAsDefined>
    </d:GridAttachment>
</d:CellLabel>
```

### Graphical representation

> TODO!

## Indentation in a grid

It is sometimes requested to indent a row stub in a grid. The code list that represents the row stubs should have some information indicating that indentation. This use case does not deal with a hierarchy, and then the code list or part of the code list should remain flat.

The attribute “levelNumber” attached to the l:Code which is the reference level is incremented with a step of 1 when the value of the indented l:Code is set. However, the indented l:Code is not part of any hierarchy with the previous, they are both flat from an XML perspective.

```xml
<l:CodeList>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>jvxx60bh</r:ID>
    <r:Version>1</r:Version>
    <r:Label>
        <r:Content xml:lang="fr-FR">TypeOfLeave</r:Content>
    </r:Label>
    <l:HierarchyType>Regular</l:HierarchyType>
    <l:Level levelNumber="1">
        <l:CategoryRelationship>Ordinal</l:CategoryRelationship>
    </l:Level>
[...]
    <l:Code levelNumber="1" isDiscrete="true">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>jvxx60bh-3</r:ID>
        <r:Version>1</r:Version>
        <r:CategoryReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>CA-jvxx60bh-3</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>Category</r:TypeOfObject>
        </r:CategoryReference>
        <r:Value>5</r:Value>
    </l:Code>
    <l:Code levelNumber="2" isDiscrete="true">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>jvxx60bh-4</r:ID>
        <r:Version>1</r:Version>
        <r:CategoryReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>CA-jvxx60bh-4</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>Category</r:TypeOfObject>
        </r:CategoryReference>
        <r:Value>6</r:Value>
    </l:Code>
    <l:Code levelNumber="2" isDiscrete="true">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>jvxx60bh-5</r:ID>
        <r:Version>1</r:Version>
        <r:CategoryReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>CA-jvxx60bh-5</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>Category</r:TypeOfObject>
        </r:CategoryReference>
        <r:Value>7</r:Value>
    </l:Code>
</l:CodeList>
```

### Graphical representation

The rows are indented in the grid under the “Fruits” row.

> TODO!

!!! question "Updating this documentation"

    :point_down: Once again, a mysterious footnote :point_down:

[^1]: A more satisfactory solution is being worked out in collaboration with the DDI Alliance
