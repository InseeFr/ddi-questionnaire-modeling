# Derived variable

The term derived or calculated variable is used here in the broad sense; it covers from the usual statistical variable derivation through aggregation, grouping or disaggregation to simpler recoding or textual variable creation (e.g. if var A=1 then var B=”small business” otherwise var B=”big company”).

The item derived/calculated variable does not exist in DDI, only the process that produces the item as output could be described with d:GenerationInstruction in the d:ProcessingInstructionScheme. Different items are requested:

- The `<d:SourceVariable>` that point to the `<l:Variable>` that are inputs of the derivation process; these are not needed for the calculation process, only for documentation purposes.
- The usual `<r:CommandCode>` to document the formulas in the calculation process. This includes:
  - the `<r:InParameter>` to capture the source values used as inputs
  - One `<r:OutParameter>` to capture the output of the calculation process
- A `<d:ControlConstructReference>` that points to the construct (usually a `<d:Sequence>`) where the process must be executed.

```xml
<d:GenerationInstruction>
    <r:Agency>fr.insee</r:Agency>
    <r:ID>jbcggtca-GI</r:ID>
    <r:Version>1</r:Version>
    <d:SourceVariable>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>jjqwaa0c</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Variable</r:TypeOfObject>
    </d:SourceVariable>
[...]
    <r:CommandCode>
        <r:Command>
            <r:ProgramLanguage>xpath</r:ProgramLanguage>
            <r:InParameter isArray="false">
                <r:Agency>fr.insee</r:Agency>
                <r:ID>jbcggtca-IP-1</r:ID>
                <r:Version>1</r:Version>
                <r:ParameterName>
                    <r:String xml:lang="fr-FR">PERCENTAGE_EXPENSES11</r:String>
                </r:ParameterName>
            </r:InParameter>
[...]
            <r:OutParameter>
                <r:Agency>fr.insee</r:Agency>
                <r:ID>jbcggtca-GOP</r:ID>
                <r:Version>1</r:Version>
            </r:OutParameter>
            <r:Binding>
                <r:SourceParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>j4nwc63q-QOP-jvxww12o</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>OutParameter</r:TypeOfObject>
                </r:SourceParameterReference>
                <r:TargetParameterReference>
                    <r:Agency>fr.insee</r:Agency>
                    <r:ID>jbcggtca-IP-1</r:ID>
                    <r:Version>1</r:Version>
                    <r:TypeOfObject>InParameter</r:TypeOfObject>
                </r:TargetParameterReference>
            </r:Binding>
[...]
            <r:CommandContent>number(if (jbcggtca-IP-1='') then '0' else jbcggtca-IP-1) + number(if (jbcggtca-IP-2='') then '0' else jbcggtca-IP-2) + number(if (jbcggtca-IP-3='') then '0' else jbcggtca-IP-3) + number(if (jbcggtca-IP-4='') then '0' else jbcggtca-IP-4) + number(if (jbcggtca-IP-5='') then '0' else jbcggtca-IP-5) + number(if (jbcggtca-IP-6='') then '0' else jbcggtca-IP-6) + number(if (jbcggtca-IP-7='') then '0' else jbcggtca-IP-7) </r:CommandContent>
        </r:Command>
    </r:CommandCode>
    <d:ControlConstructReference>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>Sequence-i6vwi0</r:ID>
        <r:Version>1</r:Version>
        <r:TypeOfObject>Sequence</r:TypeOfObject>
    </d:ControlConstructReference>
</d:GenerationInstruction>
```
