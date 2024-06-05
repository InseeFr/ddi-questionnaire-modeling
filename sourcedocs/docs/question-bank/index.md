# Question bank

A question bank is simply a set of questions which can take various forms from a business point of view. A non-exhaustive set of question types identified through the statistical surveys is presented below.

## DDI modelling of question bank

A question bank is represented by a DDI [QuestionScheme](https://ddialliance.github.io/ddimodel-web/DDI-L-3.3/item-types/QuestionScheme/) which can contain four DDI object types: QuestionItem, QuestionGrid, QuestionBlock and QuestionGroup.
The QuestionBlock and QuestionGroup are not addressed in this version of the document.

```xml
<d:QuestionScheme> 
    <r:Agency>fr.insee</r:Agency> 
    <r:ID>INSEE-SIMPSONS-QS</r:ID> 
    <r:Version>1</r:Version> 
    <r:Label> 
        <r:Content xml:lang="en-IE">QuestionScheme for the Simpsons questionnaire</r:Content> 
    </r:Label>
</d:QuestionScheme> 
```

## Question types

The classification of question types has been reviewed several times and the current proposal remains a moot point. It would be of great interest to define a common vocabulary at the European Statistical System level in order to move towards shared tools and documentation.

### Question with a single response domain

A question with a « single response domain » is a question made of a label and only one response domain whichever its type be: text, numeric, date, boolean, or less frequently any type available in the DDI schemas.

!!!warning

    There is an exception to that rule where two response domains can be defined: the response domains with a “other, please specify:” modality. It is usually (not always) associated with a text field where the respondent can enter an open value in addition to those suggested in the code list. DDI has a dedicated mechanism to handle that specific use case.

In the general case, it is represented as a DDI QuestionItem.

```xml
<d:QuestionItem> 
    <r:Agency>fr.insee</r:Agency> 
    <r:ID>INSEE-SIMPSONS-QI-1</r:ID> 
    <r:Version>1</r:Version> 
    <d:QuestionText> 
        <d:LiteralText> 
            <d:Text>How much is Margaret at checkout?</d:Text> 
        </d:LiteralText> 
    </d:QuestionText> 
    <d:NumericDomain decimalPositions="2"/>
</d:QuestionItem>
```

When a “other, please specify”-like modality is available, the `<d:QuestionItem.>` is completed with a secondary response domain (e.g. a text field) which depends on the modality “other, please specify:” which is attached to the first one thanks to a “attachmentDomain” attribute that must be equal to the value defined in the “attachmentBase” attribute from the primary response domain (usually a `<d:CodeDomain>`).

Consequently a <d:StructuredMixedResponseDomain> containing two <d:ResponseDomainInMixed> which are the placeholders of the actual response domains (e.g. <d:CodeDomain> and <d:TextDomain>) and where the “attachment*” attributes are defined.
A <d:AttachmentLocation> is required in the secondary <d:ResponseDomainInMixed> to indicate how to attach it to the primary one:

- The “attachmentDomain” attribute must be correctly set up in the <d:DomainSpecificValue> item.

```xml
<d:StructuredMixedResponseDomain>
    <d:ResponseDomainInMixed attachmentBase="1">
        <d:CodeDomain>
            <r:GenericOutputFormat codeListID="INSEE-GOF-CV">checkbox</r:GenericOutputFormat>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>j6qdqoen</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
            <r:OutParameter isArray="false">
                <r:Agency>fr.insee</r:Agency>
                <r:ID>j6qdfhvw-RDOP-jbgd8ghp</r:ID>
                <r:Version>1</r:Version>
                <r:CodeRepresentation>
                    <r:CodeListReference>
                        <r:Agency>fr.insee</r:Agency>
                        <r:ID>j6qdqoen</r:ID>
                        <r:Version>1</r:Version>
                        <r:TypeOfObject>CodeList</r:TypeOfObject>
                    </r:CodeListReference>
                </r:CodeRepresentation>
            </r:OutParameter>
            <r:ResponseCardinality maximumResponses="1"/>
        </d:CodeDomain>
    </d:ResponseDomainInMixed>
    <d:ResponseDomainInMixed>
        <d:TextDomain maxLength="200">
            <r:OutParameter isArray="false">
                <r:Agency>fr.insee</r:Agency>
                <r:ID>j6qdfhvw-RDOP-jbgd8ghq</r:ID>
                <r:Version>1</r:Version>
                <r:TextRepresentation maxLength="200"/>
            </r:OutParameter>
        </d:TextDomain>
        <d:AttachmentLocation>
            <d:DomainSpecificValue attachmentDomain="1">
                <r:Value>5</r:Value>
            </d:DomainSpecificValue>
            <r:CodeReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>j6qdqoen-3</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>Code</r:TypeOfObject>
            </r:CodeReference>
        </d:AttachmentLocation>
    </d:ResponseDomainInMixed>
</d:StructuredMixedResponseDomain>
```

- The value of the code attached to “other, please specify”, which is also referenced in the `<r:CodeReference>` item.

#### Graphical representation

The representation associated with the above first simple modelling is as follows:

> TODO!

If an “other, please specify”-like option is available, this looks like:

> TODO!

### Question with a multiple response domain

A so-called question with « a multiple response domain » is a question made of a label and several response domains typed mainly as text, numeric, date, boolean, less frequently any type available in the DDI schemas. Each of these response domains can be preceded by a label and those labels taken as a whole are not an information axis and can respectively be of different types (text, numeric, date, boolean, etc.).

!!! question "Updating this documentation"

    Inner link to the Table section? :point_down:

In most statistical questionnaires these labels are an information axis. The tendency would then be to add a column header which leads to the two-dimension grid representation (cf. § 3.2.5Table ). The case 2 Table – numeric answers is a good illustration.

It is a DDI QuestionItem with various types of response domain nested in a multiple response domain `<ResponseDomainInMixed>` contained itself -along with the other response domains- in a `<StructuredMixedResponseDomain>`. Each response domain (`<TextDomain>` in the following example) contains a certain number of elements such as `<r:Label>` which allows to add a label to the response (« house number» in the following example).

It should be noted that the DDI response format is also included in the representation of the out parameter from the response domain.

```xml
<d:QuestionItem>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-QI-102</r:ID>
    <r:Version>1</r:Version>
    <d:QuestionText>
        <d:LiteralText>
            <d:Text>What are Jay's postal details?</d:Text>
        </d:LiteralText>
    </d:QuestionText>
    <d:StructuredMixedResponseDomain>
        <d:ResponseDomainInMixed>
            <d:TextDomain>
                <r:Label>
                    <r:Content xml:lang="en-IE">House number</r:Content>
                </r:Label>
                <r:OutParameter isArray="false">
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-RDOP-102-1</r:ID>
                    <r:Version>1</r:Version>
                    <r:ParameterName>
                        <r:String>CN1</r:String>
                    </r:ParameterName>
                    <r:TextRepresentation />
                </r:OutParameter>
            </d:TextDomain>
        </d:ResponseDomainInMixed>
        <d:ResponseDomainInMixed>
            <d:TextDomain>
                <r:Label>
                    <r:Content xml:lang="en-IE">Street name</r:Content>
                </r:Label>
                <r:OutParameter isArray="false">
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-RDOP-102-2</r:ID>
                    <r:Version>1</r:Version>
                    <r:ParameterName>
                        <r:String>CN1</r:String>
                    </r:ParameterName>
                    <r:TextRepresentation />
                </r:OutParameter>
            </d:TextDomain>
        </d:ResponseDomainInMixed>
        <d:ResponseDomainInMixed>
            <d:TextDomain>
                <r:Label>
                    <r:Content xml:lang="en-IE">City</r:Content>
                </r:Label>
                <r:OutParameter isArray="false">
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-RDOP-102-3</r:ID>
                    <r:Version>1</r:Version>
                    <r:ParameterName>
                        <r:String>CN1</r:String>
                    </r:ParameterName>
                    <r:TextRepresentation />
                </r:OutParameter>
            </d:TextDomain>
        </d:ResponseDomainInMixed>
    </d:StructuredMixedResponseDomain>
</d:QuestionItem>
```

#### Graphical representation

> TODO!

### Single choice question

A question with a single response domain is a question made of a label and a response domain typed as a code list. This type of question allows the respondent to select one single response from a predefined list.

It is a QuestionItem which has as a response domain a `<CodeDomain>` with the following content model elements:

- `<ResponseCardinality>` with a « 1 » fixed value;
- `<GenericOutputFormat>` which takes its value among the following « radio », « dropdown » or « checkbox ».
- Note that the `<CodeDomain>` has an attribute “displayCode” which can be set to “true” to indicate that code value are displayed within the response domain next to the category labels.

#### Case 1 : Radio Button

```xml
<d:QuestionItem>
    <d:QuestionText>
        <d:LiteralText>
            <d:Text>Did you enjoy the movie?</d:Text>
        </d:LiteralText>
    </d:QuestionText>
    <d:CodeDomain displayCode="true">
        <r:GenericOutputFormat codeListID="INSEE-GOF-CV">radio</r:GenericOutputFormat>
        <r:CodeListReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-YesNo-CL</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>CodeList</r:TypeOfObject>
        </r:CodeListReference>
        <r:ResponseCardinality maximumResponses="1"></r:ResponseCardinality>
    </d:CodeDomain>
</d:QuestionItem>
```

#### Case 2 : Drop-down box

```xml
<d:CodeDomain>
    <r:GenericOutputFormat codeListID="INSEE-GOF-CV">dropdown</r:GenericOutputFormat>
    <r:CodeListReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CL-13</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>CodeList</r:TypeOfObject>
    </r:CodeListReference>
    <r:ResponseCardinality maximumResponses="1"/>
</d:CodeDomain>
```

#### Graphical representation

> TODO!

The representation associated with the DDI modelling is as follows:

Case 1 : Radio Button

Did you enjoy the movie⇒?

Case 2 : Drop-down box

What is the year of the first broadcast⇒?

### Multiple choice question

A multiple choice question is a question whose label is the mutual part of several sub-questions (constituting a coherent whole i.e. an information axis). Each modality of the information axis is peculiar to a specific response domain. This type of question allows to the respondent to select the best possible answers out of a number of choices from a predefined list.

A multiple choice question defines only one dimension since the second axis represented is not a « true » dimension (i.e an information axis) but rather a response domain (for instance a boolean response domain or a « Yes/No » code domain).

It is represented by a DDI QuestionGrid:

- its unique dimension is a `<CodeDomain>` included in an element `<GridDimension>` ;
- the response domain is a `<CodeDomain>` included in a multiple response domain `<GridResponseDomain>` nested in a `<StructuredMixedGridResponseDomain>`.

Each `<CodeDomain>` has a reference to the code list that represents it as well as a `<GenericOutputFormat>` that types the code list representing the response domain.

It should be noted that the format of the DDI response is also contained in the out parameter representation defined at the beginning of the question.

In the example given in §3.5.2 Graphical Representation, a QuestionGrid has an element `<CodeDomain>` that references a code list « Yes/No » (represented as radio buttons).

!!!info "⇒Design choice"

    In this case we chose to define a variable that is measured for each modality of the information axis.

    An alternative would have been to use vectors of variables allowing to capture the response list corresponding to all the chosen modalities of the information axis. This solution was rejected essentially for technical implementation reasons. Although the DDI QuestionGrid element is used, this use case is not classified as a table (3.2.5.Table). This means that DDI has nothing strictly equivalent to what is known as a Table by subject-matter people.

```xml
<d:QuestionItem>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-QI-1</r:ID>
    <r:Version>1</r:Version>
    <d:QuestionText>
        <d:LiteralText>
            <d:Text>How much is Margaret at checkout?</d:Text>
        </d:LiteralText>
    </d:QuestionText>
    <d:NumericDomain decimalPositions="2"/>
</d:QuestionItem>
```

When a “other, please specify”-like modality is available, the `<d:QuestionGrid>` is completed with a secondary response domain (e.g. a text field) which depends on the modality “other, please specify:” which is attached to the first one thanks to a “attachmentDomain” attribute that must be equal to the value defined in the “attachmentBase” attribute from the primary grid response domain (usually a `<d:CodeDomain>`). Consequently a `<d:StructuredGridMixedResponseDomain>` containing two `<d:GridResponseDomainInMixed>` which are the placeholders of the actual response domains (e.g. `<d:CodeDomain>` and `<d:TextDomain>`) and where the “attachment*” attributes are defined.

A `<d:ResponseAttachmentLocation>` is required in the secondary `<d:GridResponseDomainInMixed>` to indicate how to attach it to the primary one:

- The “attachmentDomain” attribute must be correctly set up in the `<d:DomainSpecificValue>` item.
- The value of the code attached to “other, please specify” in `<d:DomainSpecificValue>`, which is also referenced in the `<r:CodeReference>` item when the primary response domain is a code domain.

An example is provided in the 3.2.5 Table paragraph.

```xml
<d:QuestionGrid>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-QG-21</r:ID>
    <r:Version>1</r:Version>
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QOP-21-1</r:ID>
        <r:Version>1</r:Version>
        <r:CodeRepresentation>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-CL-YesNo</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </r:CodeRepresentation>
    </r:OutParameter>
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QOP-21-2</r:ID>
        <r:Version>1</r:Version>
        <r:CodeRepresentation>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-CL-YesNo</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </r:CodeRepresentation>
    </r:OutParameter>
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QOP-21-3</r:ID>
        <r:Version>1</r:Version>
        <r:CodeRepresentation>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-CL-YesNo</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </r:CodeRepresentation>
    </r:OutParameter>
    <r:Binding>
        <r:SourceParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-21-1</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:SourceParameterReference>
        <r:TargetParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-21-1</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:TargetParameterReference>
    </r:Binding>
    <r:Binding>
        <r:SourceParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-21-2</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:SourceParameterReference>
        <r:TargetParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-21-2</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:TargetParameterReference>
    </r:Binding>
    <r:Binding>
        <r:SourceParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-21-3</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:SourceParameterReference>
        <r:TargetParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-21-3</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:TargetParameterReference>
    </r:Binding>
    <d:QuestionText>
        <d:LiteralText>
            <d:Text>Do you like the following ice cream flavours?</d:Text>
        </d:LiteralText>
    </d:QuestionText>
    <d:GridDimension rank="1" displayCode="false" displayLabel="false">
        <d:CodeDomain>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS-CL-21</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </d:CodeDomain>
    </d:GridDimension>
Page 25 sur 72
    <d:StructuredMixedGridResponseDomain>
        <d:GridResponseDomainInMixed>
            <d:CodeDomain>
                <r:GenericOutputFormat codeListID="INSEE-GOF-CV">radio</r:GenericOutputFormat>
                <r:CodeListReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-YesNo-CL</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>CodeList</r:TypeOfObject>
                </r:CodeListReference>
                <r:ResponseCardinality maximumResponses="1"/>
            </d:CodeDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="1" rangeMaximum="1"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
        <d:GridResponseDomainInMixed>
            <d:CodeDomain>
                <r:GenericOutputFormat codeListID="INSEE-GOF-CV">radio</r:GenericOutputFormat>
                <r:CodeListReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-YesNo-CL</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>CodeList</r:TypeOfObject>
                </r:CodeListReference>
                <r:ResponseCardinality maximumResponses="1"/>
            </d:CodeDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="2" rangeMaximum="2"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
        <d:GridResponseDomainInMixed>
            <d:CodeDomain>
                <r:GenericOutputFormat codeListID="INSEE-GOF-CV">radio</r:GenericOutputFormat>
                <r:CodeListReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-YesNo-CL</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>CodeList</r:TypeOfObject>
                </r:CodeListReference>
                <r:ResponseCardinality maximumResponses="1"/>
            </d:CodeDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="3" rangeMaximum="3"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
    </d:StructuredMixedGridResponseDomain>
</d:QuestionGrid>
```

#### Graphical representation

> TODO!

The representation associated with the DDI modelling is as follows:
Do you like the following ice cream flavours?⇒
Vanilla
Strawberry
Apple
Bacon
An alternative representation would be as follows, however the DDI modelling and the business objects would remain the same (the columns yes-no are the response fields associated with each row and not an information axis).
Do you like the following ice cream flavours?⇒
Yes
No
Vanilla
Strawberry
Apple
Bacon
This example could have been represented by check boxes instead of radio buttons yes/no. In this case, only the response domain is different.

### Table

A Table is a two-way table. It's a question made of a label and a response domain defined by two dimensions. The information located at the intersection of a row and a column corresponds to a response.

There are a lot of types of tables, more or less equivalent from a semantic point of view, however their representations can be very varied. The main purpose here is to describe different use cases relevant to the survey designer, and provide a DDI modelling.

!!!info "One dimension versus two dimensions"

    This is a semantic distinction not a representational one.
    
    Further to the choice made in the paragraph 3.2.4 (no vector), a two-dimension table is a table where each row-column modality intersection corresponds to a variable that is measured.
    In the case of a “fake” one-dimension table, what could be interpreted as a dimension, is only the list of the response modalities for each row (please see the second representation in 3.2.4).
    
    For instance , in the Case 1: Table – boolean responses , the modes of transport and the geographic areas are “real” information axis that are intersected each other. Two DDI dimensions are then defined , one for the modes of transport, the other for the geographic areas. Each cell corresponds to a measured variable.
    
    On the other hand in the use case in the paragraph 3.2.4. Multiple choice question , the code list « Yes/No » is a simple response field for each modality of the dimension related to the question: in this example, a list of ice cream flavours is given to the discretion of the respondent. There will be only one dimension and the code list « Yes/No » will be part of the response domain (CodeDomain). Each line is a measured variable.

#### Table (with two explicit information axis)

A two-way table with two explicit information axis is a table with two dimensions whose modalities are already known.

DDI Modelling (generic)

It is a QuestionGrid with two dimensions and a response field associated with the intersection of each modality of each dimension, as opposed to the QuestionGrid with only one dimension according to the rule mentioned in the text box « O ne dimension versus two dimensions ».

The representation of the out parameters in the question was voluntarily left out, for XML verbosity purposes, the one of the out parameters in the response domain was only given once (to learn more about the value representation in the <ResponseDomain>, please see § 3.7.1.Response domains).

##### Use case 1 : Table – boolean responses

In the DDI below, we chose as an example a check-off response domain (DDI NominalDomain) for each intersection of the two dimensions. The entire table is akin to a question with several possible response modalities where each response modality takes its meaning from the intersection of information axis. The reasoning remains the same when each intersection defines a single choice response (radio button yes-no), only the type of the response domain changes (CodeDomain in this case).

```xml
<d:QuestionGrid>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-QG-63</r:ID>
    <r:Version>1</r:Version>
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QOP-63-1</r:ID>
        <r:Version>1</r:Version>
    </r:OutParameter>
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QOP-63-2</r:ID>
        <r:Version>1</r:Version>
    </r:OutParameter>
[...]
    <r:OutParameter isArray="false">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QOP-63-18</r:ID>
        <r:Version>1</r:Version>
    </r:OutParameter>
    <r:Binding>
        <r:SourceParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-63-1</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:SourceParameterReference>
        <r:TargetParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-63-1</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:TargetParameterReference>
    </r:Binding>
    <r:Binding>
        <r:SourceParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-63-2</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:SourceParameterReference>
        <r:TargetParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-63-2</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:TargetParameterReference>
    </r:Binding>
[...]
    <r:Binding>
        <r:SourceParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-63-18</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:SourceParameterReference>
        <r:TargetParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-RDOP-63-18</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
        </r:TargetParameterReference>
    </r:Binding>
    <d:QuestionText>
        <d:LiteralText>
            <d:Text>With which characters and in which country did the hero travel?</d:Text>
        </d:LiteralText>
    </d:QuestionText>
    <d:GridDimension rank="1" displayCode="true" displayLabel="false">
        <d:CodeDomain>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS-CL-63</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </d:CodeDomain>
    </d:GridDimension>
    <d:GridDimension rank="2" displayCode="true" displayLabel="false">
        <d:CodeDomain>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS-CL-64</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </d:CodeDomain>
    </d:GridDimension>
    <d:StructuredMixedGridResponseDomain>
        <d:GridResponseDomainInMixed>
            <d:NominalDomain>
                <r:GenericOutputFormat codeListID="INSEE-GOF-CV">checkbox</r:GenericOutputFormat>
                <r:OutParameter isArray="false">
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-RDOP-63-1</r:ID>
                    <r:Version>1</r:Version>
                    <r:CodeRepresentation>
                        <r:CodeSubsetInformation>
                            <r:IncludedCode>
                                <r:CodeReference>
                                    <r:Agency>fr.insee</r:Agency>
                                    <r:ID>INSEE-COMMUN-CL-Booleen-1</r:ID>
                                    <r:Version>1</r:Version>
                                    <r:TypeOfObject>Code</r:TypeOfObject>
                                </r:CodeReference>
                            </r:IncludedCode>
                        </r:CodeSubsetInformation>
                    </r:CodeRepresentation>
                    <r:DefaultValue/>
                </r:OutParameter>
                <r:ResponseCardinality maximumResponses="1"/>
            </d:NominalDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="1" rangeMaximum="1"/>
                    <d:SelectDimension rank="2" rangeMinimum="1" rangeMaximum="1"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
        <d:GridResponseDomainInMixed>
            <d:NominalDomain>
                <r:GenericOutputFormat codeListID="INSEE-GOF-CV">checkbox</r:GenericOutputFormat>
                <r:OutParameter isArray="false">
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-RDOP-63-2</r:ID>
                    <r:Version>1</r:Version>
                    <r:CodeRepresentation>
                        <r:CodeSubsetInformation>
                            <r:IncludedCode>
                                <r:CodeReference>
                                    <r:Agency>fr.insee</r:Agency>
                                    <r:ID>INSEE-COMMUN-CL-Booleen-1</r:ID>
                                    <r:Version>1</r:Version>
                                    <r:TypeOfObject>Code</r:TypeOfObject>
                                </r:CodeReference>
                            </r:IncludedCode>
                        </r:CodeSubsetInformation>
                    </r:CodeRepresentation>
                    <r:DefaultValue/>
                </r:OutParameter>
                <r:ResponseCardinality maximumResponses="1"/>
            </d:NominalDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="1" rangeMaximum="1"/>
                    <d:SelectDimension rank="2" rangeMinimum="2" rangeMaximum="2"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
[...]
        <d:GridResponseDomainInMixed attachmentBase="18">
            <d:NominalDomain>
                <r:GenericOutputFormat codeListID="INSEE-GOF-CV">checkbox</r:GenericOutputFormat>
                <r:OutParameter isArray="false">
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>INSEE-SIMPSONS-RDOP-63-18</r:ID>
                    <r:Version>1</r:Version>
                    <r:CodeRepresentation>
                        <r:CodeSubsetInformation>
                            <r:IncludedCode>
                                <r:CodeReference>
                                    <r:Agency>fr.insee</r:Agency>
                                    <r:ID>INSEE-COMMUN-CL-Booleen-1</r:ID>
                                    <r:Version>1</r:Version>
                                    <r:TypeOfObject>Code</r:TypeOfObject>
                                </r:CodeReference>
                            </r:IncludedCode>
                        </r:CodeSubsetInformation>
                    </r:CodeRepresentation>
                    <r:DefaultValue/>
                </r:OutParameter>
                <r:ResponseCardinality maximumResponses="1"/>
            </d:NominalDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="3" rangeMaximum="3"/>
                    <d:SelectDimension rank="2" rangeMinimum="6" rangeMaximum="6"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
        <d:TextDomain>
            <r:Label>
                <r:Content xml:lang='fr-FR'>
                Please, specify :
                </r:Content>
            </r:Label>
        </d:TextDomain>
        <d:ResponseAttachmentLocation>
            <d:DomainSpecificValue attachmentDomain="18">
                <r:Value>1</r:Value>
            </d:DomainSpecificValue>
            <r:CodeReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-COMMUN-CL-Booleen-1</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>Code</r:TypeOfObject>
            </r:CodeReference>
        </d:ResponseAttachmentLocation>
    </d:GridResponseDomainInMixed>
</d:StructuredMixedGridResponseDomain>
</d:QuestionGrid>
```

###### Graphical Representation

The representation associated with the DDI modelling is as follows:

> TODO!

##### Use case 2 : Table – numeric answers

The use case 2 presented below is equivalent from the DDI point of view to the case 1 contrary to what the representation suggests.

The difference, as opposed to the case 1, is as follows:

- The response domains are `<d:NumericDomain>` ;
- The unit of measurement is the Dollar. The « $ » icon is defined in the `<r:MeasurementUnit>` contained in the `<l:VariableRepresentation>` of a `<l:Variable>`;
- The totals are not handled well by DDI yet. An issue is opened and discussed with the DDI Alliance.

It should be noted that the column headers and the row stubs are defined as follows:

- Regarding the table dimension 2 (the column in this case), it is the first category from the code list representing the dimension which defines what appears as the column header (« Price ») ;
- Regarding the total of the table dimension 1, it is simply a category (« Total expenses »).
- The stub “Products” is not a category but the label of the `<CodeList>` representing the dimension. Please note that the `<GridDimension>` attribute “displayLabel” has to be set to “true” in this case.

```xml
<d:QuestionGrid>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-QG-52</r:ID>
    <r:Version>1</r:Version>
    <d:QuestionText>
        <d:LiteralText>
            <d:Text>Please estimate your expenses at the mini-market ?</d:Text>
        </d:LiteralText>
    </d:QuestionText>
    <d:GridDimension rank="1" displayCode="false" displayLabel="true">
        <d:CodeDomain>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS-CL-52</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </d:CodeDomain>
    </d:GridDimension>
    <d:GridDimension rank="2" displayCode="false" displayLabel="false">
        <d:CodeDomain>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS-CL-58</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </d:CodeDomain>
    </d:GridDimension>
    <d:StructuredMixedGridResponseDomain>
        <d:GridResponseDomainInMixed>
            <d:NumericDomain>
                <r:NumberRange>
                    <r:Low>0</r:Low>
                </r:NumberRange>
                <r:NumericTypeCode codeListID="INSEE-ND-CV">Decimal</r:NumericTypeCode>
            </d:NumericDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="1" rangeMaximum="1"/>
                    <d:SelectDimension rank="2" rangeMinimum="1" rangeMaximum="1"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
        <d:GridResponseDomainInMixed>
            <d:NumericDomain>
                <r:NumberRange>
                    <r:Low>0</r:Low>
                </r:NumberRange>
                <r:NumericTypeCode codeListID="INSEE-ND-CV">Decimal</r:NumericTypeCode>
                <r:Label>
                    <r:Content>
                        <xhtml:p>
                            <xhtml:b>$</xhtml:b>
                        </xhtml:p>
                    </r:Content>
                </r:Label>

            </d:NumericDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="2" rangeMaximum="2"/>
                    <d:SelectDimension rank="2" rangeMinimum="1" rangeMaximum="1"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
        <d:GridResponseDomainInMixed>
            <d:NumericDomain>
                <r:NumberRange>
                    <r:Low>0</r:Low>
                </r:NumberRange>
                <r:NumericTypeCode codeListID="INSEE-ND-CV">Decimal</r:NumericTypeCode>
                <r:Label>
                    <r:Content>
                        <xhtml:p>
                            <xhtml:b>$</xhtml:b>
                        </xhtml:p>
                    </r:Content>
                </r:Label>
            </d:NumericDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="3" rangeMaximum="3"/>
                    <d:SelectDimension rank="2" rangeMinimum="1" rangeMaximum="1"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
        <d:GridResponseDomainInMixed>
            <d:NumericDomain>
                <r:NumberRange>
                    <r:Low>0</r:Low>
                </r:NumberRange>
                <r:NumericTypeCode codeListID="INSEE-ND-CV">Decimal</r:NumericTypeCode>
                <r:Label>
                    <r:Content>
                        <xhtml:p>
                            <xhtml:b>$</xhtml:b>
                        </xhtml:p>
                    </r:Content>
                </r:Label>
            </d:NumericDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="4" rangeMaximum="4"/>
                    <d:SelectDimension rank="2" rangeMinimum="1" rangeMaximum="1"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>
        <d:GridResponseDomainInMixed>
            <d:NumericDomain>
                <r:NumberRange>
                    <r:Low>0</r:Low>
                </r:NumberRange>
                <r:NumericTypeCode codeListID="INSEE-ND-CV">Decimal</r:NumericTypeCode>
                <r:Label>
                    <r:Content>
                        <xhtml:p>
                            <xhtml:b>$</xhtml:b>
                        </xhtml:p>
                    </r:Content>
                </r:Label>
            </d:NumericDomain>
            <d:GridAttachment>
                <d:CellCoordinatesAsDefined>
                    <d:SelectDimension rank="1" rangeMinimum="5" rangeMaximum="5"/>
                    <d:SelectDimension rank="2" rangeMinimum="1" rangeMaximum="1"/>
                </d:CellCoordinatesAsDefined>
            </d:GridAttachment>
        </d:GridResponseDomainInMixed>

</d:QuestionGrid>
```

```xml
<l:CategoryScheme>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-CAS-17</r:ID>
    <r:Version>0.1.0</r:Version>
    <r:Label>
        <r:Content xml:lang="en-IE">List of product categories</r:Content>
    </r:Label>
    <l:Category>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-17-1</r:ID>
        <r:Version>0.1.0</r:Version>
        <r:Label>
            <r:Content xml:lang="en-IE">Ice cream</r:Content>
        </r:Label>
    </l:Category>
    <l:Category>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-17-2</r:ID>
        <r:Version>0.1.0</r:Version>
        <r:Label>
            <r:Content xml:lang="en-IE">Candies</r:Content>
        </r:Label>
    </l:Category>
    <l:Category>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-17-3</r:ID>
        <r:Version>0.1.0</r:Version>
        <r:Label>
            <r:Content xml:lang="en-IE">T-Bone</r:Content>
        </r:Label>
    </l:Category>
    <l:Category>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-17-4</r:ID>
        <r:Version>0.1.0</r:Version>
        <r:Label>
            <r:Content xml:lang="en-IE">Donut</r:Content>
        </r:Label>
    </l:Category>
</l:CategoryScheme>
<l:CategoryScheme>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-CAS-18</r:ID>
    <r:Version>0.1.0</r:Version>
    <r:Label>
        <r:Content xml:lang="en-IE">List of the total category</r:Content>
    </r:Label>
    <l:Category>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-18-1</r:ID>
        <r:Version>0.1.0</r:Version>
        <r:Label>
            <r:Content xml:lang="en-IE">Total expenses</r:Content>
        </r:Label>
    </l:Category>
</l:CategoryScheme>
<l:CategoryScheme>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-CAS-19</r:ID>
    <r:Version>1</r:Version>
    <r:Label>
        <r:Content xml:lang="en-IE">Category list amount</r:Content>
    </r:Label>
    <l:Category>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-19-1</r:ID>
        <r:Version>1</r:Version>
        <r:Label>
            <r:Content xml:lang="en-IE">Amount</r:Content>
        </r:Label>
    </l:Category>
</l:CategoryScheme>
```

```xml
ID>INSEE-SIMPSONS-CL-10-1</r:ID>
        <r:Version>1</r:Version>
        <r:CategoryReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-CA-17-1</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>Category</r:TypeOfObject>
        </r:CategoryReference>
        <r:Value>1</r:Value>
    </l:Code>
    <l:Code levelNumber="1" isDiscrete="true">
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CL-10-2</r:ID>
        <r:Version>1</r:Version>
        <r:CategoryReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-SIMPSONS-CA-17-2</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>Category</r:TypeOfObject>
        </r:CategoryReference>
        <r:Value>2</r:Value>
    </l:Code>
    <l:Code levelNumber="1" isDiscrete="true">
        <r:Agency>fr.insee</r:Agency> ID>INSEE-SIMPSONS-CL-10-3</r:ID>
    <r:Version>1</r:Version>
    <r:CategoryReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-18-3</r:ID>

        <r:Version>1</r:Version>
        <r:TypeOfObject>Category</r:TypeOfObject>
    </r:CategoryReference>
    <r:Value>3</r:Value>
</l:Code>
<l:Code levelNumber="1" isDiscrete="true">
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-CL-10-4</r:ID>
    <r:Version>1</r:Version>
    <r:CategoryReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-18-4</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Category</r:TypeOfObject>
    </r:CategoryReference>
    <r:Value>4</r:Value>
</l:Code>
<l:Code levelNumber="1" isDiscrete="true">
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-CL-10-5</r:ID>
    <r:Version>1</r:Version>
    <r:CategoryReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-18-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Category</r:TypeOfObject>
    </r:CategoryReference>
    <r:Value>5</r:Value>
</l:Code>
</l:CodeList>
<l:CodeList>
<r:Agency>fr.insee</r:Agency>
<r:ID>INSEE-SIMPSONS-CL-12</r:ID>
<r:Version>1</r:Version>
<l:HierarchyType>Regular</l:HierarchyType>
<l:Level levelNumber="1">
    <l:CategoryRelationship>Ordinal</l:CategoryRelationship>
</l:Level>
<l:Code levelNumber="1" isDiscrete="true">
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-CL-12-1</r:ID>
    <r:Version>1</r:Version>
    <r:CategoryReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-CA-19-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Category</r:TypeOfObject>
    </r:CategoryReference>
    <r:Value>1</r:Value>
</l:Code>
</l:CodeList>
```

```xml
<l:Variable>
    <r:Label>
        <r:Content xml:lang="fr-FR">Expenses at the supermarket</r:Content>
    </r:Label>
    <l:VariableRepresentation>
        <r:NumericRepresentation>
            <r:MeasurementUnit>$</r:MeasurementUnit>
            <r:NumberRange>
                <r:Low isInclusive="true">0</r:Low>
            </r:NumberRange>
            <r:NumericTypeCode controlledVocabularyID="INSEE-CIS-NTC-CV">Format
Numérique</r:NumericTypeCode>
        </r:NumericRepresentation>
    </l:VariableRepresentation>
</l:Variable>
```

###### Graphical representation

> TODO!

##### Case 3 : Table – complex table

> LATER
