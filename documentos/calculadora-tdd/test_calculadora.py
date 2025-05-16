import pytest
from calculadora import Calculadora

class TestCalculadora:
    @pytest.fixture
    def calc(self):
        return Calculadora()
    
    def test_adicao(self, calc):
        assert calc.adicionar(2, 3) == 5
        assert calc.adicionar(-1, 1) == 0
        
    def test_subtracao(self, calc):
        assert calc.subtrair(5, 3) == 2
        assert calc.subtrair(10, 15) == -5

    
