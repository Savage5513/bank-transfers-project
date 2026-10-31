# Спецификация API (REST)

## 1. Создание перевода (POST /api/v1/transfers)

Описание: Инициирует перевод денежных средств между счетами одного клиента.

Метод: POST
URL: /api/v1/transfers

### Заголовки (Headers)
- Content-Type: application/json
- Authorization: Bearer <token>

### Тело запроса (Request Body)

{
  "idempotency_key": "string (UUID)",
  "from_account_id": 10,
  "to_account_id": 11,
  "amount": 5000.00
}

### Успешный ответ (201 Created)

{
  "transaction_id": 1,
  "status": "Успех",
  "message": "Перевод выполнен успешно"
}

### Ответ с ошибкой (400 Bad Request - Недостаточно средств)

{
  "error_code": "INSUFFICIENT_FUNDS",
  "message": "На счете недостаточно средств для совершения перевода"
}

### Ответ с ошибкой (409 Conflict - Дубликат запроса)

{
  "error_code": "DUPLICATE_TRANSACTION",
  "message": "Этот перевод уже был выполнен ранее"
}