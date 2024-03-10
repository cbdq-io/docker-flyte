Feature: Delta Lake
  Ensure that Spark and Python packages are suitable for Delta Lake 3.1.X.
  See <https://docs.delta.io/latest/releases.html>.

  Scenario Outline: Validate Python Package Versions
    Given local host
    And the TestInfra pip package is <pip_package>
    When the package is installed
    Then the major number is <major>
    And the minor number is <minor>

    Examples:
      | pip_package | major | minor |
      | delta-spark | 3     | 1     |
      | pyspark     | 3     | 5     |
