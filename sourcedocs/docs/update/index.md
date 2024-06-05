# :construction: Update notes :construction:

This section contains notes on what could or should be done in order to update this documentation.

As mention in the [home page](/), the documentation is annotated with this kind of sections:

!!! question "Updating this documentation"

    Some text.

which proposes some specific and in-place changes.

For more general consideration, there is this page.

## Linting

The source markdown files could be linted using [Markdownlint](https://github.com/DavidAnson/markdownlin), in this case it could be sometimes better to [escape some rules](https://github.com/DavidAnson/markdownlint/tree/v0.34.0?tab=readme-ov-file#configuration).

An example: when linking internally to a section of a page, Markdown lint could raise a warning with the fragment use. The code below:

```markdown
[...] previous use case [Simple example « Hideable »](#simple-example-hideable) where « Greyed out » [...]
```

will raise the warning `→ MD051/link-fragments: Link fragments should be valid` whereas in this case the fragment `#simple-example-hideable` is valid for MKDocs.

To escape the rule, simply add an escape marker:

```markdown
<!-- markdownlint-disable MD051 -->
[...] previous use case [Simple example « Hideable »](#simple-example-hideable) where « Greyed out » [...]
```

## Already done

- Better indented XML is some cases
- Correct some XML

## Structure of the documentation

1. The _Question bank_ section is huge, it should probably be splitted in N sub-sections (i.e. sub-pages).

## Graphical representations

1. Should we use "abstract" graphical representations, or real-ones (using Stromae DSFR for example) ?

## DDI code

1. When referencing a DDI element, we should choose and stick with a form:
    1. AnElement / x:AnElement
    2. `<AnElement>` / `<x:AnElement>`
2. for the first or each use of an element, link to the definition in the field docs, <https://ddialliance.github.io/ddimodel-web/DDI-L-3.3/> for 3.3 for example ?
