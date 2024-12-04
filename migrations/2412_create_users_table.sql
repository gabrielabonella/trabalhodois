CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

IF NOT EXISTS (SELECT 1 FROM migrations WHERE migration_name = '2412_create_users_table')
BEGIN
    INSERT INTO migrations (migration_name) VALUES ('2412_create_users_table');
END

