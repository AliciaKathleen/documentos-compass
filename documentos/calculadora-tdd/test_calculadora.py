import pytest
from calculadora import Calculadora

class TestCalculadora:
    @pytest.fixture
    def calc(self):
        return Calculadora()