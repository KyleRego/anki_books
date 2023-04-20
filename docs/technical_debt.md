# Technical debt

Technical debt is added when the decision is made to develop quickly with the intention to return later and improve the work. This document trackes areas to return to and improve later.

## Development environment issues

- Changes to `app/javascript` files do not reload automatically.

## Testing issues

- Difficulty with simulating the web browser filling in the editor, pressing Enter, and filling in the editor more.
  - Preventing a feature test that would test adding all 6 subheadings
  - Preventing tests of adding nested lists

## Application issues

- Current users approach is temporary and in the future, Devise can be used but this will require a mail server.
- New, create, and destroy article actions not implemented
- Seems to be a bug where the "Headers" button in the article editor is activated, but that button only toggles the headers button group
