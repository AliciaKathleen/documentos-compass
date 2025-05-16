# *Calculadora em Python com TDD*

*Pasta:* `documentos-compass/documentos/calculadora-tdd`  
*Descrição:* Projeto de calculadora desenvolvido com *Test-Driven Development* usando Python e Pytest.

---

## *📌 Funcionalidades*

* *➔ Operações Básicas:*
  * *✔️ Adição (`adicionar(a, b)`)*
  * *✔️ Subtração (`subtrair(a, b)`)*
  * *✔️ Multiplicação (`multiplicar(a, b)`)*
  * *✔️ Divisão (`dividir(a, b)`)*

* *➔ Operações Extras:*
  * *✔️ Potenciação (`potencia(base, exp)`)*
  * *✔️ Raiz Quadrada (`raiz_quadrada(n)`)*

## *Como Usar*

### *Pré-requisitos*
* Python 3.10+
* Pytest (*instalável via `pip install pytest`*)

### *Instalação*
```bash
cd documentos-compass/documentos/calculadora-tdd
python -m pytest test_calculadora.py -v

============================ *EXEMPLOS DE SAÍDA DOS TESTES* ============================
test_calculadora.py::*TestCalculadora::test_adicao PASSED*               [14%]
test_calculadora.py::*TestCalculadora::test_divisao_por_zero PASSED*     [100%]
============================= *7 passed in 0.01s* ============================