"""Delta Lake feature tests."""

import semver
import testinfra
from pytest_bdd import given, parsers, scenario, then, when


@scenario('../features/delta.feature', 'Validate Python Package Versions')
def test_validate_python_package_versions():
    """Validate Python Package Versions."""


@given('local host', target_fixture='host')
def _():
    """local host."""
    return testinfra.get_host('local://')


@given(parsers.parse('the TestInfra pip package is {pip_package}'), target_fixture='pip_package')
def _(host: testinfra.host.Host, pip_package: str):
    """the TestInfra pip package is <pip_package>."""
    return host.pip(pip_package)


@when('the package is installed')
def _(pip_package):
    """the package is installed."""
    assert pip_package.is_installed


@then(parsers.parse('the major number is {expected_major:d}'))
def _(pip_package, expected_major):
    """the major number is <major>."""
    ver = semver.Version.parse(pip_package.version)
    actual_major_version = ver.major
    assert actual_major_version == expected_major


@then(parsers.parse('the minor number is {expected_minor:d}'))
def _(pip_package, expected_minor):
    """the minor number is <minor>."""
    ver = semver.Version.parse(pip_package.version)
    actual_minor_version = ver.minor
    assert actual_minor_version == expected_minor
