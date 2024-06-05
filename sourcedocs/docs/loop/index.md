# Loop

It is quite common in household survey questionnaires to ask the same question block to each household member. The element needed in DDI (and other survey programming language) is a loop.

A loop is a way of describing an action which loops until a limiting condition is met. This action often takes the form of a given set of questions or even of a questionnaire. In this case the condition is defined by the number of statistical units surveyed (e.g. persons or businesses).

!!!example

    A first questionnaire form surveys a business, and a second one is specific to each employee. A loop is then needed to submit the same questionnaire to each employee, the stop condition being met when the total number of employees is reached.

An example which loops on the number of employees of a business previously surveyed is used here.

The XML chunk below is the usual DDI modelling of a loop. A loop, similarly to the `<IfThenElse>` or the `<Sequence>`, is a type of control construct.

The `<InitialValue>` gives the information on the command used to set the initial value for the process. It could be a simple value just as the example shows.

The `<LoopWhile>` defines the command used to determine whether the relation condition is met. Eno uses an xpath command that checks that the count of generated occurrences of a given sequence is lower than an external parameter (surrounded by the Danish letter `¤`). The sequence sub-string identifier in the example is 'INSEE-ECMOSSETAB2-SEQ-3-a-' and the external parameter representing the number of employees is 'nbsal'.

The `<StepValue>` is the command or simple value used to set the incremental or step value for the process.

The `<LoopVariableReference>` is not used, but it should be, in order to reference the variable defining the loop. However, since the variable is very often not collected but provided a priori by the questionnaire owner, it is modelled as an usual external parameter (with the `ø` character).

```xml
<d:Loop>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-ECMOSSETAB2-LO-SALARIE</r:ID>
    <r:Version>1</r:Version>
    <d:InitialValue>
        <r:Command>
            <r:ProgramLanguage>xpath</r:ProgramLanguage>
            <r:CommandContent>1</r:CommandContent>
        </r:Command>
    </d:InitialValue>
    <d:LoopWhile>
        <r:Command>
            <r:ProgramLanguage>xpath</r:ProgramLanguage>
            <r:CommandContent>count(d:Sequence/child::r:ID[substring(normalize-space(text()),1,26)='INSEE-ECMOSSETAB2-SEQ-3-a-'])&lt;ønbsalø</r:CommandContent>
        </r:Command>
    </d:LoopWhile>
    <d:StepValue>
        <r:Command>
            <r:ProgramLanguage>xpath</r:ProgramLanguage>
            <r:CommandContent>1</r:CommandContent>
        </r:Command>
    </d:StepValue>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-ECMOSSETAB2-SEQ-3-a-0</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Sequence</r:TypeOfObject>
    </d:ControlConstructReference>
</d:Loop>
```

The `<VariableGroup>` has a specific role in the context of a loop: it allows to loop on the instance variables attached to the questions that are in a loop. This is the way the Eno generator links an external variable to a loop and specify that the external variable has to be initialised for each instance of the loop.

Two sub-elements are particularly important:

- the `<BasedOnObject>` allows to link the variable group to the correct `<Loop>` by reference
- the `<TypeOfVariableGroup>` indicates to Eno how to process this loop. In the example below the 'QuestionLoop' value means that questions should be replicated. Up to now the other type supported by Eno is 'TableLoop' that Eno interprets as 'instantiate each variable defined in the group any time a row is added to the table'.

Each variable that is duplicated any time the loop condition is met is referenced in the variable group.

```xml
<l:VariableGroup>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-ECMOSSETAB2-VLO-SALARIE</r:ID>
    <r:Version>1</r:Version>
    <r:BasedOnObject>
        <r:BasedOnReference>
            <r:Agency>fr.insee</r:Agency>
            <r:ID>INSEE-ECMOSSETAB2-LO-SALARIE</r:ID>
            <r:Version>1</r:Version>
            <r:TypeOfObject>Loop</r:TypeOfObject>
        </r:BasedOnReference>
    </r:BasedOnObject>
    <l:TypeOfVariableGroup>QuestionLoop</l:TypeOfVariableGroup>
    <l:VariableGroupName>
        <r:String>BOUCLE_SALARIES</r:String>
    </l:VariableGroupName>
    <r:VariableReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-ECMOSSETAB2-VR-NOM_SAL</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Variable</r:TypeOfObject>
    </r:VariableReference>
    <r:VariableReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-ECMOSSETAB2-VR-QUIT_ETB</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Variable</r:TypeOfObject>
    </r:VariableReference>
    <r:VariableReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-ECMOSSETAB2-VR-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Variable</r:TypeOfObject>
    </r:VariableReference>
    <r:VariableReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-ECMOSSETAB2-VR-1_1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Variable</r:TypeOfObject>
    </r:VariableReference>
    <r:VariableReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-ECMOSSETAB2-VR-1_2</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Variable</r:TypeOfObject>
    </r:VariableReference>
</l:VariableGroup>
```
