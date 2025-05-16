class Calculadora:
    def adicionar(self, a, b):
        return a + b

    def subtrair(self, a, b):
        return a - b

    def multiplicar(self, a, b):
        return a * b

    def dividir(self, a, b):
        if b == 0:
            raise ValueError("Divisão por zero não permitida!")
        return a / b

    def potencia(self, base, expoente):
        return base ** expoente  

    def raiz_quadrada(self, numero):
        if numero < 0:
            raise ValueError("Não existe raiz real de número negativo!")
        return numero ** 0.5  