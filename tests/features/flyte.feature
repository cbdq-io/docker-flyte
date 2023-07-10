Feature: Docker Image for Flyte

    Scenario: Python Version
        Given the host with URL "local://" is ready
        When the command is "python3 --version"
        Then the command return code is 0
        And the command "python3" exists in path
        And the command stdout contains "3.11."

    Scenario: Flyte Python Package
        Given the host with URL "local://" is ready
        When the pip package is flytekit
        Then the pip package is present
        And the pip package is latest
        And the pip package version is 1.7.0
        And the pip check is OK

    Scenario: Flyte Non-Root User
        Given the host with URL "local://" is ready
        When the user is flyte
        Then the user is present
        And the user group is flyte
        And the user shell is /usr/sbin/nologin
