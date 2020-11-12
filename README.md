<img src="http://159.65.210.101/php-actions.png" align="right" alt="PHP Actions for Github" />

Run your PHPUnit tests in your Github Actions.
==============================================

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
    - uses: actions/checkout@v2
    - uses: php-actions/composer@v1 # or alternative dependency management
    - uses: php-actions/phpunit@v1
    # ... then your own project steps ...
```

Example
-------

We've put together an extremely simple example application that uses `php-actions/phpunit`. Check it out here: https://github.com/php-actions/example-phpunit.

Inputs
------

The following configuration options are available:

+ `config` Path to the `phpunit.xml` file (default: `test/phpunit/phpunit.xml`)
+ `junit` Path to junit output file (default: `test/phpunit/_junit/junit.xml`)
+ `memory` The memory limit to run your tests with (default: `512M`)
+ `bootstrap` The path to the bootstrap file (default: `vendor/autoload.php`)
+ `php_version` The version of PHP to use e.g. `7.4` (default: latest)
+ `phpunit_version` The version of PHPUnit to use e.g. `9` or `9.4.2` (default: latest)

The syntax for passing in a custom input is the following:

```yaml
...

jobs:
  unit-tests:

    ...

    - name: PHPUnit tests
      uses: php-actions/phpunit@v1
      with:
        configuration: custom/path/to/phpunit.xml
        memory_limit: 256M
```

If you require other configurations of phpunit, please request them in the [Github issue tracker](https://github.com/php-actions/phpunit/issues)

Versions
--------

Previously, the Github Actions release version numbers were in sync with the PHPUnit version, but this imposed too many limitations. For the next 12 months, v7, v8 and v9 branches will still point to their existing commits, but we have reverted to v1-based Actions releases, allowing PHPUnit version number to be specified from your configuration, using the `phpunit_version` input variable.

Any PHPUnit version available from https://phar.phpunit.de/ are supported.

Please note the version number specified within your Action configuration must match your composer.json major version number. For example, if your composer.json requires `phpunit/phpunit 8.5.8`, you must use `phpunit_version: 8.5.8`, as major versions of PHPUnit are incompatible with each other.  

If you require a specific version that is not compatible with Github Actions for some reason, please make a request in the [Github issue tracker](https://github.com/php-actions/phpunit/issues).

If you found this repository helpful, please consider [sponsoring the developer][sponsor].

[sponsor]: https://github.com/sponsors/g105b
