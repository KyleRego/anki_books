# Overview

There are two categories of tests in Anki Books:
- RSpec examples
- Cucumber tests

## RSpec

The RSpec examples cover the unit tests and small integration tests. It should be used to test the granular behavior of objects. The examples should be written such that when the RSpec test suite is run with the `--format doc` option, the output provides documentation of what the objects should do. The RSpec examples are in `spec` and should generally have a 1-to-1 mapping with the source code files (e.g. the RSpec tests for `article.rb` should be in `article_spec.rb`).

## Cucumber

The Cucumber tests cover the feature tests, end-to-end tests, and any tests involving an automated web browser.

The Cucumber tests are written in the Gherkin language of "Given, When, Then" which are translated into Ruby according to the step definitions. The Cucumber tests are in `features` and the step definitions are in `features/step_definitions`. Any step definitions that are specifically for debugging can be defined in `step_definitions/common_steps.rb`. Screenshots saved by Capybara seem to go to `tmp/capybara` by default and the `test.log` in `log` may also be useful for debugging.

Capybara provides the DSL for simulating the user interacting with the application. It requires running the application being tested. RackTest is the driver it uses by default, however this driver does not execute JavaScript. Selenium is used as the driver instead so that the JavaScript can be tested. It turns out that Puma works a lot better with Selenium than Passenger, so although Passenger is the production application server, the Puma gem is included in the Gemfile in the test group and is used in the tests.

If you are using WSL2/Ubuntu, the following commands can be used to install Google Chrome for the automated tests (https://scottspence.com/posts/use-chrome-in-ubuntu-wsl):

```
sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt -y install ./google-chrome-stable_current_amd64.deb
```

With the automated web browser, the step definitions/Cucumber process and the web application serving the requests are different processes and both have a connection to the test database. This means that transactions cannot be used because the transactions are never committed to the database and each process is unable to see any data that was in the database from the other process. Therefore, the truncation strategy is used instead.
