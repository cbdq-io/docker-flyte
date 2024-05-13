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
        And the TestInfra pip package version is 1.12.0
        And the TestInfra pip check is OK
        Examples:
          | pip_package           |
          | flytekit              |
          | flytekitplugins-spark |

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
          | file_name                                                                |
          | /etc/apt/trusted.gpg                                                     |
          | /etc/apt/sources.list.d/archive_uri-https_apt_corretto_aws-bookworm.list |

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
