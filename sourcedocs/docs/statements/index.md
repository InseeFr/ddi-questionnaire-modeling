# Statements

!!! question "Updating this documentation"

    For every XML snippet → We probably need to get rid of the `XHTML` tags, we don't do that anymore?

A __Statement__ is a generic term that designates a textual element from the questionnaire (other than the question text, response modalities…).
The different types of statement are:

- comment,
- instruction,
- help,
- warning.

## DDI modelling of statements

A statement is represented by a DDI [Instruction](https://ddialliance.github.io/ddimodel-web/DDI-L-3.3/item-types/Instruction/). The text displayed with the element InstructionText.
For typing the instruction, DDI is a little bit “twisted” with the use of the element InstructionName.

## Type of statement : « Comment »

__A comment__ is a statement which conveys quite a « generic » information on the context without interaction with the interviewee/interviewer. It is an introductory text preceding one or more questions generally.

Example: «We are going to move on to the questions on the computer and internet access equipment in your household».

In DDI:

```xml
<d:InstructionName> 
    <r:String xml:lang="en-IE">Comment</r:String>
</d:InstructionName>
```

## Type of statement: « Instruction »

An __instruction__ is a formal step to be completed by the interviewee/interviewer.

For instance: « Enter 0 if your business has not incurred any innovation expense. » or « Check off all appropriate boxes. ».

```xml
<d:Instruction> 
    <r:Agency>fr.insee</r:Agency> 
    <r:ID>INSEE-SIMPSONS-II-22</r:ID> 
    <r:Version>1</r:Version> 
    <d:InstructionName> 
        <r:String xml:lang="en-IE">Instruction</r:String> 
    </d:InstructionName> 
    <d:InstructionText> 
        <d:LiteralText> 
            <d:Text> 
                Check off all appropriate boxes
            </d:Text>
        </d:LiteralText> 
    </d:InstructionText>
</d:Instruction>
```

## Type of statement « Help »

An __help__ is a statement that enhances the understanding of a question and its expected response.

Example: « Include non-salary employees.»

```xml
<d:InstructionName> 
    <r:String xml:lang="en-IE">Help</r:String>
</d:InstructionName>
```

## Type of statement « Warning »

A warning is a message alerting the interviewee an error occurred or an error can potentially occur (a sort of cautionary statement).
For instance: « The sum of the respective turnover is not equal to the total turnover. Please correct it.»

```xml
<d:InstructionName> 
    <r:String xml:lang="en-IE">Warning</r:String>
</d:InstructionName>
```

## Type of statement « Tooltip »

A message which appears when a cursor is positioned over an icon, image, hyperlink, or other element in the graphical user interface. It took over from the “footnote” type implemented in the early Eno versions. Those messages are culled from an instruction booklet essentially. Although this type of statement is mainly representational, its content is in most of the cases an instruction.

It is implemented in several elements, however in two different ways to make up for a DDI shortfall in the `<Category>` that misses an instruction reference feature:

- The tooltip instruction are handled in the sequence and question texts correctly using the `<InterviewerInstructionReference>` element the same way it is implemented for the other types of statement. In those cases, the tooltip icon is attached the sequence/question text automatically.
- In a category often used to capture the row or column header in a table, the mechanism implemented is a temporary solution (DDI 3.3 should add a `<InterviewerInstructionReference>` in the `<Category>`). It makes use of `<xhtm:p>` markup and more precisely its “id” attribute in the instruction, set to “ftn” concatenated with an incremental number. This “ftnxxx” value prefixed by a “#” character is referenced in the attribute “href” of the `<xhtml:a>` markup embedded at the category `<Content>` element.

!!! question "Updating this documentation"

    Add a Stromae DSFR tooltip link? :arrow_right: <https://inseefr.github.io/Lunatic-DSFR/storybook/iframe.html?args=darkMode:!false&id=components-mdlink--default&viewMode=story>

Eno has chosen the following icon, however this depends on the Eno implementing environment totally: `TODO!`

Since the tooltip is an instruction semantically, its “type” segment in the ID is “II”.

### Case 1: Question text

The first case below shows the “usual” and “correct” implementation in a `<QuestionItem>`.

```xml
<d:Instruction> 
    <r:Agency>fr.insee</r:Agency> 
    <r:ID>INSEE-SIMPSONS-II-8</r:ID> 
    <r:Version>1</r:Version> 
    <d:InstructionName> 
        <r:String xml:lang="fr-FR">tooltip</r:String> 
    </d:InstructionName> 
    <d:InstructionText> 
        <d:LiteralText> 
            <d:Text xml:lang="en-IE"> 
                Expenses refers to the money spent on the goods
            </d:Text> 
        </d:LiteralText> 
    </d:InstructionText>
</d:Instruction>
```

```xml
<d:QuestionItem> 
    <r:Agency>fr.insee</r:Agency> 
    <r:ID>INSEE-ANTIPOLV1-QI-3-1-1</r:ID> 
    <r:Version>1</r:Version>
[...]
    <d:QuestionText> 
        <d:LiteralText> 
            <d:Text> Please estimate the expenses at the minimarket</d:Text> 
        </d:LiteralText> 
    </d:QuestionText>
[...]
    <d:InterviewerInstructionReference>
        <r:Agency>fr.insee</r:Agency> 
        <r:ID>INSEE-ANTIPOLV1-II-8</r:ID>
        <r:Version>1</r:Version> 
        <r:TypeOfObject>Instruction</r:TypeOfObject> 
    </d:InterviewerInstructionReference>
</d:QuestionItem>
```

### Case 2: Category in a grid

The category which contains the tooltip reference is used à the row stub in a table.

```xml
<d:Instruction>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-II-31</r:ID>
    <r:Version>1</r:Version>
    <d:InstructionName>
        <r:String xml:lang="fr-FR">tooltip</r:String>
    </d:InstructionName>
    <d:InstructionText>
    <d:LiteralText>
        <d:Text xml:lang="en-IE">Ice cream refers to A soft frozen food made with sweetened and flavoured milk fat.</d:Text>
    </d:LiteralText>
</d:InstructionText>
</d:Instruction>
```

```xml
<l:Category>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSON-CA-3</r:ID>
    <r:Version>1</r:Version>
    <r:Label>
        <r:Content xml:lang="en-IE">
            Ice cream
        </r:Content>
    </r:Label>
</l:Category>
```

### Graphical representation

> TODO! Screenshots to and/or link from Stromae DSFR and Queen

#### Case 1: Question text

> TODO!

#### Case 2: Category in a grid

> TODO!

## Conditional text

A conditional text is a dynamic text either in a question, or an instruction with a value determined by one or
more responses to questions from the survey instrument, or a calculated variable, or external information.

The condition for displaying a text is expressed within a command contained in a <d:ConditionalText>
element. DDI does not handle currently the link between a text to be displayed and its related condition: the
special character `¤` is used around the identifier of the placeholder in the dynamic portion of the <d:Text> to
indicate where to insert the configurable value[^1].

```xml
<d:InstructionText>
    <d:LiteralText>
        <d:Text xml:lang="fr-FR">The sum of percentages is: ¤jbcggtca-GOP¤%. The total of</d:Text>
    </d:LiteralText>
    <d:ConditionalText>
        <r:SourceParameterReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>jbcggtca-GOP</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>OutParameter</r:TypeOfObject>
            </r:SourceParameterReference>
    </d:ConditionalText>
</d:InstructionText>
```

!!! warning

    Configurable text is requested is other part of a questionnaire where the `<d:ConditionalText>` is not available, e.g. the content of `<r:Label>` in a `<l:Category>`. In these use cases, the special character `¤` is directly in the content without reference any `r:SourceParameter` or defining any `r:Command`.

### Graphical representation

If the parameter bcggtca-GOP takes the value 87 then the statement text is as follows:

> The sum of percentages is: 87%. The total of percentages must be equal to 100%.

!!! question

    Mysterious footnote below :point_down:, must be explicited.

[^1]: A more satisfactory solution has been worked out in collaboration with the DDI Alliance in the version 3.3.
