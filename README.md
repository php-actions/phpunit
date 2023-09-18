<img src="http://159.65.210.101/php-actions.png" align="right" alt="PHP Actions for Github" />

Run PHPUnit tests in Github Actions.
====================================

PHPUnit is a programmer-oriented testing framework for PHP.

It is an instance of the xUnit architecture for unit testing frameworks.

Usage
-----

Create your Github Workflow configuration in `.github/workflows/ci.yml` or similar.

```yaml
name: CI

on: [push]

jobs:
  build-test:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - uses: php-actions/composer@v6 # or alternative dependency management
    - uses: php-actions/phpunit@v3
    # ... then your own project steps ...
```

### Version numbers

This action is released with semantic version numbers, but also tagged so the latest major release's tag always points to the latest release within the matching major version.

Please feel free to use `uses: php-actions/phpunit@v3` to always run the latest version of v3, or `uses: php-actions/phpunit@v3.0.0` to specify the exact release.

Example
-------

We've put together an extremely simple example application that uses `php-actions/phpunit`. Check it out here: https://github.com/php-actions/example-phpunit.

Inputs
------

The following configuration options are available:

+ `version` The version of PHPUnit to use e.g. `latest`, `9` or `9.5.0` (default: `composer` - use the version specified in composer.json)
+ `php_version` The version of PHP to use e.g. `7.4` (default: latest)
+ `php_extensions` Space-separated list of extensions using [php-build][php-build] e.g. `xdebug mbstring` (default: N/A)
+ `vendored_phpunit_path` The path to a phar file already present on the runner (default: N/A)
+ `configuration` Path to the `phpunit.xml` file (default: `test/phpunit/phpunit.xml`)
+ `log_junit` Log test execution in JUnit XML format to file
+ `log_teamcity` Log test execution in TeamCity format to file 
+ `testdox_html` Write documentation in HTML format to file
+ `testdox_text` Write documentation in Text format to file
+ `memory_limit` The memory limit to run your tests with (default: `128M`)
+ `bootstrap` The path to the bootstrap file
+ `filter` Filter which tests to run
+ `testsuite` Specify a testsuite to run
+ `group` Only runs tests from the specified group(s)
+ `exclude_group` Exclude tests from the specified group(s)
+ `test_suffix` Only search for test in files with specified suffix(es)
+ `whitelist` Path to directory to whitelist for code coverage analysis
+ `coverage_clover` Generate code coverage report in Clover XML format
+ `coverage_cobertura` Generate code coverage report in Cobertura XML format
  required
+ `coverage_crap4j` Generate code coverage report in Crap4J XML format
+ `coverage_html` Generate code coverage report in HTML format
+ `coverage_php` Export PHP_CodeCoverage object to file
+ `coverage_text` Generate code coverage report in text format (true to output to console, path to output to file)
+ `coverage_xml` Generate code coverage report in PHPUnit XML format
+ `args` Extra arguments to pass to the phpunit binary

The syntax for passing in a custom input is the following:

```yaml
...

jobs:
  unit-tests:

    ...

    - name: PHPUnit tests
      uses: php-actions/phpunit@v3
      with:
        configuration: "custom/path/to/phpunit.xml"
        memory_limit: "256M"
```

If you require other configurations of phpunit, please request them in the [Github issue tracker][issues]

PHP and PHPUnit versions
------------------------

It's possible to run any version of PHPUnit under any version of PHP, with any PHP extensions you require. This is configured with the following inputs:

+ `version` - the version number of PHPUnit to run e.g. `latest`, `9` or `9.5.0` (default: `composer`). Using the default value, `composer` will install the version specified in `composer.json`
+ `php_version` - the version number of PHP to use e.g. `7.4` (default: latest)
+ `php_extensions` - a space-separated list of extensions to install using [php-build][php-build] e.g. `xdebug mbstring` (default: N/A)

Please note the version number specified within your Action configuration must match your `composer.json` major version number. For example, if your composer.json requires `phpunit/phpunit 8.5.8`, you must use the `version: 8.5.8` input, as major versions of PHPUnit are incompatible with each other.

If you require a specific version that is not compatible with Github Actions for some reason, please make a request in the [Github issue tracker][issues].

Coverage
--------

To store the code coverage, use the `coverage_*` input that is appropriate for your needs. Coverage information is made possible by using the xdebug extension, which will be required to be added to the `php_extensions` input to work.

Example:

```yaml
jobs:
  unit-tests:

    ...

    - name: PHPUnit tests
      uses: php-actions/phpunit@v3
      with:
        php_extensions: "xdebug"
        coverage_clover: "coverage/clover.xml"
```

The above example will output coverage information to the terminal. Pass a file path to output to a file.

If you want to report coverage information somewhere, please see the [code-coverage] action.

Github Actions releases
-----------------------

Previously, the Github Actions release version numbers were in sync with the PHPUnit version, but this imposed too many limitations. For the next 12 months (until 30th November 2021), v7, v8 and v9 branches will still point to their existing commits, but we have reverted to v1-based Actions releases, allowing PHPUnit version number to be specified from your configuration, using the `version` input variable.

***

If you found this repository helpful, please consider [sponsoring the developer][sponsor].

[issues]: https://github.com/php-actions/phpunit/issues
[php-build]: https://github.com/php-actions/php-build
[code-coverage]: https://github.com/php-actions/code-coverage
[sponsor]: https://github.com/sponsors/g105b
