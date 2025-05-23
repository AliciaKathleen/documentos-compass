# 🚀 Testes API Restful-Booker - Robot Framework


## 📋 Descrição
Projeto desenvolvido durante a sprint de testes APIs Compass UOL.

## 🛠️ Tecnologias
- Robot Framework
- RequestsLibrary
- Python 3.10+

## ⚡ Como Executar

### Pré-requisitos
```bash
pip install -r requirements.txt
```

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
