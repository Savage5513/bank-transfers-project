-- 1. СОЗДАНИЕ СТРУКТУРЫ ТАБЛИЦ

CREATE TABLE Users (
    id INTEGER PRIMARY KEY,
    full_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Accounts (
    id INTEGER PRIMARY KEY,
    users_id INTEGER,
    account_number VARCHAR(20),
    balance DECIMAL(15, 2),
    currency VARCHAR(3),
    FOREIGN KEY (users_id) REFERENCES Users(id)
);

CREATE TABLE Limits (
    user_id INTEGER PRIMARY KEY,
    daily_spent DECIMAL(15, 2),
    last_transaction_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Transactions (
    id INTEGER PRIMARY KEY,
    idempotency_key VARCHAR(100) UNIQUE,
    from_account_id INTEGER,
    to_account_id INTEGER,
    amount DECIMAL(15, 2),
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_account_id) REFERENCES Accounts(id),
    FOREIGN KEY (to_account_id) REFERENCES Accounts(id)
);

-- 2. НАПОЛНЕНИЕ ТЕСТОВЫМИ ДАННЫМИ

INSERT INTO Users (id, full_name, phone) VALUES 
(1, 'Данил', '89081112233'),
(2, 'Мария', '89000000000');

INSERT INTO Accounts (id, users_id, account_number, balance, currency) VALUES 
(10, 1, '40817810000000000010', 50000.00, 'RUB'),
(11, 1, '40817810000000000011', 10000.00, 'RUB'),
(20, 2, '40817810000000000020', 15000.00, 'RUB');

INSERT INTO Limits (user_id, daily_spent, last_transaction_date) VALUES 
(1, 0.00, '2023-10-28');

-- 3. ПРИМЕР ТРАНЗАКЦИИ (Закомментировано, чтобы не срабатывало при создании)

-- BEGIN TRANSACTION;
-- UPDATE Accounts SET balance = balance - 5000 WHERE id = 10;
-- UPDATE Accounts SET balance = balance + 5000 WHERE id = 11;
-- INSERT INTO Transactions (idempotency_key, from_account_id, to_account_id, amount, status) 
-- VALUES ('test_key_1', 10, 11, 5000.00, 'Успех');
-- COMMIT;