# 🚀 Testes API Restful-Booker - Robot Framework

<img src="https://img.shields.io/badge/Robot%20Framework-000000?style=for-the-badge&logo=robot-framework&logoColor=white" alt="Robot Framework">
<img src="https://img.shields.io/badge/API%20Testing-FF6C37?style=for-the-badge&logo=postman&logoColor=white" alt="API Testing">
<img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub">

## 📋 Descrição
Testes automatizados para a API [Restful-Booker](https://restful-booker.herokuapp.com/apidoc/index.html) implementando:

```gherkin
Feature: CRUD Completo
  Scenario: Testar todos os endpoints
    Given Autenticação válida
    When Executar operações CRUD
    Then Validar responses e status codes
```

## 🛠️ Tecnologias
- Robot Framework
- RequestsLibrary
- Python 3.10+

## ⚡ Como Executar

### Pré-requisitos
```bash
pip install -r requirements.txt
```

### Comandos
| Ação                | Comando                           |
|---------------------|-----------------------------------|
| Executar todos      | `robot tests/bookings.robot`      |
| Executar específico | `robot -t "Test Name" tests/...`  |
| Gerar relatório     | Abrir `log.html` após execução    |

## 🌐 Endpoints Testados
| Verbo   | Endpoint          | Status |
|---------|-------------------|--------|
| GET     | `/booking`        | ✅      |
| POST    | `/booking`        | ✅      |
| PUT     | `/booking/{id}`   | ✅      |
| DELETE  | `/booking/{id}`   | ✅      |

## 📁 Estrutura
```tree
.
├── requirements.txt
└── tests/
    ├── __init__.robot
    ├── auth.robot
    └── bookings.robot
```
