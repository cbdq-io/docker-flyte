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

    Scenario Outline: Fixed System Vulnerabilities
      Given the TestInfra host with URL "local://" is ready
      When the Vulnerability is <Vulnerability>
      And the TestInfra package is <Library>
      Then the TestInfra package version will be greater than or equal to <FixedVersion>

      Examples:
        | Vulnerability | Library | FixedVersion    |
        | CVE-2024-5171 | libaom3 | 3.6.0-1+deb12u1 |

    Scenario: Flyte Non-Root User
        Given the TestInfra host with URL "local://" is ready
        When the TestInfra user is flyte
        Then the TestInfra user is present
        And the TestInfra user group is flyte
        And the TestInfra user shell is /usr/sbin/nologin

    Scenario Outline: Corretto Configuration
        Given the TestInfra host with URL "local://" is ready
        When the TestInfra file is <file_name>
        Then the TestInfra file is present
        And the TestInfra file type is file
        And the TestInfra file owner is root
        And the TestInfra file group is root
        Examples:
          | file_name                                |
          | /usr/share/keyrings/corretto-keyring.gpg |
          | /etc/apt/sources.list.d/corretto.list    |

    Scenario Outline: Check Commands Installed in the Path
      Given the TestInfra host with URL "local://" is ready within 10 seconds
      Then the TestInfra command "<command>" exists in path
      Examples:
        | command |
        | java    |

    Scenario: Check Java 11 is Installed
      Given the TestInfra host with URL "local://" is ready
      When the TestInfra command is "java -version"
      And the TestInfra package is java-11-amazon-corretto-jdk
      Then the TestInfra command stderr contains "Corretto-11"
      And the TestInfra command stderr contains the regex "openjdk version \"11\\W[0-9]"
      And the TestInfra command stdout is empty
      And the TestInfra command return code is 0
      And the TestInfra package is installed

    Scenario: Entrypoint
      Given the TestInfra host with URL "local://" is ready
      When the TestInfra file is /usr/local/bin/entrypoint.sh
      Then the TestInfra file type is file
      And the TestInfra file owner is flyte
      And the TestInfra file group is flyte
      And the TestInfra file mode is 0o555
