Feature: Docker Image for Flyte
    Scenario: Python Version
        Given the host with URL "local://" is ready
        When the command is "python3 --version"
        Then the command return code is 0
        And the command "python3" exists in path
        And the command stdout contains "3.11."

    Scenario Outline: Flyte Python Packages
        Given the host with URL "local://" is ready
        When the pip package is <pip_package>
        Then the pip package is present
        And the pip package is latest
        And the pip package version is 1.8.3
        And the pip check is OK
        Examples:
          | pip_package           |
          | flytekit              |
          | flytekitplugins-spark |

    Scenario: Flyte Non-Root User
        Given the host with URL "local://" is ready
        When the user is flyte
        Then the user is present
        And the user group is flyte
        And the user shell is /usr/sbin/nologin

    Scenario Outline: Corretto Configuration
        Given the host with URL "local://" is ready
        When the file is <file_name>
        Then the file is present
        And the file type is file
        And the file owner is root
        And the file group is root
        Examples:
          | file_name                                                                |
          | /etc/apt/trusted.gpg                                                     |
          | /etc/apt/sources.list.d/archive_uri-https_apt_corretto_aws-bookworm.list |

    Scenario Outline: Check Commands Installed in the Path
      Given the host with URL "local://" is ready within 10 seconds
      Then the command "<command>" exists in path
      Examples:
        | command |
        | java    |

    Scenario: Check Java 11 is Installed
      Given the host with URL "local://" is ready
      When the command is "java -version"
      And the package is java-11-amazon-corretto-jdk
      Then the command stderr contains "Corretto-11"
      And the command stderr contains the regex "openjdk version \"11\\W[0-9]"
      And the command stdout is empty
      And the command return code is 0
      And the package is installed
