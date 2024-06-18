"""Examples of step definitions for Testinfra BDD feature tests."""
import os
import testinfra_bdd
from pytest_bdd import then, scenarios

scenarios('../features/flyte.feature')


# Ensure that the PyTest fixtures provided in testinfra-bdd are available to
# your test suite.
pytest_plugins = testinfra_bdd.PYTEST_MODULES


@then('the TestInfra pip package matches the expected flytekit version')
def _(testinfra_bdd_host):
    """the TestInfra pip package matches the expected flytekit version."""
    expected_version = os.environ['FLYTE_KIT_VERSION']
    pip_package = testinfra_bdd_host.pip_package
    actual_version = pip_package.version
    assert actual_version == expected_version
