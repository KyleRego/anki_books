# Technical debt

Technical debt is added when the decision is made to develop quickly with the intention to return later and improve the work. This document tracks areas to return to and improve later.

## Testing issues

- There is an upstream issue with the drivers used by Capybara/Selenium preventing testing a user interacting with the HTML drag and drop API reordering notes.
  - https://github.com/w3c/webdriver/issues/1488#issuecomment-1474112065
  - https://github.com/mozilla/geckodriver/issues/1450
  - https://github.com/bormando/selenium-tools/issues/6
  - https://github.com/w3c/webdriver/issues/1488

## Where manual testing should be performed

- Reordering the notes with drag and drop

## Application issues

- Current users approach is temporary and in the future, Devise can be used but this will require a mail server.
- Not possible to delete articles yet
- More CSS needed.
