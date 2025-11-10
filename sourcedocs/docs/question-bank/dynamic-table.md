# Dynamic table question

## Dynamic table with a size determined by an expression

The size of a dynamic table can be determined by a formula, for instance a VTL expression.

In this case, the `QuestionGrid` object have a `ConditionForContinuation` in the `Roster` of its `GridDimension` of "rank 1".

Example of a questionnaire containing a dynamic table question, whose size is defined by a VTL expression:

```xml
<DDIInstance>
  <g:ResourcePackage>
    <d:QuestionScheme>

      <!-- Dynamic table question -->
      <d:QuestionGrid>
        <r:Agency>fr.insee</r:Agency>
        <r:ID>id-dynamic-table</r:ID>
        <r:Version>1</r:Version>
        <!-- (...) Question grid name -->
        <!-- (...) Out parameters of the question grid -->
        <!-- (...) Bindings of the question grid -->
        <!-- (...) Question text -->

        <!-- Grid dimension of "rank 1" that defines the size of the dynamic table -->
        <d:GridDimension displayCode="false" displayLabel="false" rank="1">
          <d:Roster baseCodeValue="1" codeIterationValue="1">
            <d:ConditionForContinuation>
              <r:Command>
                <r:ProgramLanguage>vtl</r:ProgramLanguage>
                <!-- (...) In parameters of the expression -->
                <!-- (...) Bindings of the expression -->
                <r:CommandContent><!-- Expression that determines the size of the roster --></r:CommandContent>
              </r:Command>
            </d:ConditionForContinuation>
          </d:Roster>
        </d:GridDimension>

        <!-- Fake grid dimension of "rank 2" (the size of a dynamic table is only defined by the "rank 1" dimension -->
        <d:GridDimension displayCode="false" displayLabel="false" rank="2">
          <d:CodeDomain>
            <r:CodeListReference>
              <r:Agency>fr.insee</r:Agency>
              <r:ID>id-dynamic-table-secondDimension-fakeCL-1</r:ID>
              <r:Version>1</r:Version>
              <r:TypeOfObject>CodeList</r:TypeOfObject>
            </r:CodeListReference>
          </d:CodeDomain>
        </d:GridDimension>

        <d:StructuredMixedGridResponseDomain>
          <d:GridResponseDomainInMixed>
            <!-- Response domains and grid attachments of the question grid -->
          </d:GridResponseDomainInMixed>
        </d:StructuredMixedGridResponseDomain>

      </d:QuestionGrid>

    </d:QuestionScheme>
  </g:ResourcePackage>
</DDIInstance>
```
