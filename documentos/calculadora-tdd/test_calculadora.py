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

    def test_multiplicacao(self, calc):
        assert calc.multiplicar(3, 4) == 12
        assert calc.multiplicar(-2, 5) == -10

    def test_divisao(self, calc):
        assert calc.dividir(10, 2) == 5
        assert calc.dividir(1, 2) == 0.5

    def test_divisao_por_zero(self, calc):
        with pytest.raises(ValueError):
            calc.dividir(10, 0)

    def test_potencia(self, calc):
        assert calc.potencia(2, 3) == 8
        assert calc.potencia(5, 0) == 1

    def test_raiz_quadrada(self, calc):
        assert calc.raiz_quadrada(9) == 3
        assert calc.raiz_quadrada(16) == 4