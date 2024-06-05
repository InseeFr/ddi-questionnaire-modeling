# Variable

In the context of a questionnaire, only the instance variables are used (conceptual and represented variables are not considered).

The instance variable takes its value from the dataset context . The instance variable is used to described the data collected.

!!!example

    For the instance variable « Sex », Margaret is a (w, Woman) and Bart is a (m, Man).

The instance variable includes both:

- a reference to the question which collects it;
- and the output parameter (OutParameter) defined in this question that contains its value.
- A unit of measurement defined as r:MeasurementUnit, in the VariableRepresentation (cf. 3.2.5 use case 2).
- A representation which gives, among other things, its format.

```xml
<l:Variable>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>INSEE-SIMPSONS-VR-SEX</r:ID>
    <r:Version>1</r:Version>
    <l:VariableName>
        <r:String xml:lang="en-IE">SEX</r:String>
    </l:VariableName>
    <r:Label>
        <r:Content xml:lang="en-IE">Sex</r:Content>
    </r:Label>
    <r:SourceParameterReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QGOP-2-1-4</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>OutParameter</r:TypeOfObject>
    </r:SourceParameterReference>
    <r:QuestionReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>INSEE-SIMPSONS-QG-2-1</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>QuestionGrid</r:TypeOfObject>
    </r:QuestionReference>
    <l:VariableRepresentation>
        <r:CodeRepresentation>
            <r:CodeListReference>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>INSEE-SIMPSONS-CL-4</r:ID>
                <r:Version>1</r:Version>
                <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
        </r:CodeRepresentation>
    </l:VariableRepresentation>
</l:Variable>
```
