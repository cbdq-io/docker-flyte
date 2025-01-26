Feature: Docker Image for Flyte
    Scenario: Python Version
        Given the TestInfra host with URL "local://" is ready
        When the TestInfra command is "python3 --version"
        Then the TestInfra command return code is 0
        And the TestInfra command "python3" exists in path
        And the TestInfra command stdout contains "3.12."

    Scenario Outline: Flyte Python Packages
        Given the TestInfra host with URL "local://" is ready
        When the TestInfra pip package is <pip_package>
        Then the TestInfra pip package is present
        And the TestInfra pip package is latest
        And the TestInfra pip package matches the expected flytekit version
        And the TestInfra pip check is OK
        Examples:
          | pip_package           |
          | flytekit              |
          | flytekitplugins-spark |

    Scenario: PySpark Version Matches Docker Image Tag
      Given the TestInfra host with URL "local://" is ready
      When the TestInfra pip package is pyspark
      Then the TestInfra pip package version is 3.5.4

    Scenario Outline: Other Python Packages
      Given the TestInfra host with URL "local://" is ready
      When the TestInfra pip package is <pip_package>
      Then the TestInfra pip package is present
      Examples:
        | pip_package |
        | kubernetes  |
        | setuptools  |

    Scenario Outline: Expected Executables
      Given the TestInfra host with URL "local://" is ready
      When the TestInfra command is <executable>
      Then the TestInfra command "<executable>" exists in path
      Examples:
        | executable      |
        | flyte-cli       |
        | pyflyte         |
        | pyflyte-execute |
        | pyspark         |

    Scenario: Pre-Flyte Check
      Given the TestInfra host with URL "local://" is ready
      When the TestInfra command is "pyflyte --help"
      Then the TestInfra command return code is 0

    Scenario: Flyte Non-Root User
        Given the TestInfra host with URL "local://" is ready
        When the TestInfra user is flytekit
        Then the TestInfra user is present
        And the TestInfra user group is flytekit
        And the TestInfra user uid is 1000
        And the TestInfra user gid is 1000
        And the TestInfra user shell is /usr/sbin/nologin

    Scenario Outline: Check Commands Installed in the Path
      Given the TestInfra host with URL "local://" is ready within 10 seconds
      Then the TestInfra command "<command>" exists in path
      Examples:
        | command |
        | java    |
        | useradd |
