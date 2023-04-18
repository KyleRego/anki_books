# Technical debt

Technical debt is added when the decision is made to develop quickly with the intention to return later and improve the work. This document trackes areas to return to and improve later.

- Syntax highlighting does not work on first page load when updating article -- not clear why.
- Tailwind CSS classes do not load until the application server is restarted. Same with changes to `app/javascript` files.
- Current users approach is temporary and in the future, Devise can be used but this will require a mail server.
- New, create, and destroy article actions not implemented
- No build/deploy script yet
- Trix editor needs more feature tests
