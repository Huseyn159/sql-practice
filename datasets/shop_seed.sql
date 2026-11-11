CREATE TABLE categories (
                            id    BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                            name  VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE products (
                          id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                          name         VARCHAR(100) NOT NULL,
                          category_id  BIGINT NOT NULL REFERENCES categories (id),
                          price        NUMERIC(10,2) NOT NULL CHECK (price > 0)
);

CREATE TABLE customers (
                           id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                           full_name      VARCHAR(100) NOT NULL,
                           city           VARCHAR(50) NOT NULL,
                           registered_at  DATE NOT NULL
);

CREATE TABLE orders (
                        id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        customer_id  BIGINT NOT NULL REFERENCES customers (id),
                        status       VARCHAR(20) NOT NULL CHECK (status IN ('paid', 'pending', 'cancelled')),
                        created_at   TIMESTAMP NOT NULL
);

CREATE TABLE order_items (
                             order_id    BIGINT NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
                             product_id  BIGINT NOT NULL REFERENCES products (id),
                             qty         INT NOT NULL CHECK (qty > 0),
                             unit_price  NUMERIC(10,2) NOT NULL CHECK (unit_price > 0),  -- satış anındakı qiymət
                             PRIMARY KEY (order_id, product_id)
);

INSERT INTO categories (name) VALUES
                                  ('Elektronika'),  -- 1
                                  ('Kitab'),        -- 2
                                  ('Geyim'),        -- 3
                                  ('Ev');           -- 4  (məhsulu yoxdur)

INSERT INTO products (name, category_id, price) VALUES
                                                    ('Noutbuk',          1, 1800.00),  -- 1
                                                    ('Simsiz siçan',     1,   25.00),  -- 2
                                                    ('Qulaqlıq',         1,  120.00),  -- 3
                                                    ('Clean Code',       2,   45.00),  -- 4
                                                    ('Əli və Nino',      2,   18.00),  -- 5
                                                    ('Kurtka',           3,  210.00),  -- 6
                                                    ('Futbolka',         3,   30.00),  -- 7
                                                    ('Monitor',          1,  520.00);  -- 8  (heç satılmayıb)

INSERT INTO customers (full_name, city, registered_at) VALUES
                                                           ('Əli Həsənov',      'Bakı',     '2025-03-10'),  -- 1
                                                           ('Leyla Məmmədova',  'Bakı',     '2025-07-22'),  -- 2
                                                           ('Rəşad Quliyev',    'Gəncə',    '2025-11-02'),  -- 3
                                                           ('Nigar Əliyeva',    'Sumqayıt', '2026-01-15'),  -- 4
                                                           ('Elvin Hüseynov',   'Gəncə',    '2026-02-28'),  -- 5
                                                           ('Səbinə Kərimova',  'Bakı',     '2026-05-05'),  -- 6
                                                           ('Kamran Rzayev',    'Sumqayıt', '2026-08-19');  -- 7  (sifarişi yoxdur)

INSERT INTO orders (customer_id, status, created_at) VALUES
                                                         (1, 'paid',      '2026-08-03 10:15'),  -- 1
                                                         (1, 'paid',      '2026-09-12 18:40'),  -- 2
                                                         (1, 'cancelled', '2026-10-01 09:05'),  -- 3
                                                         (2, 'paid',      '2026-08-20 14:00'),  -- 4
                                                         (2, 'pending',   '2026-11-02 11:30'),  -- 5
                                                         (3, 'paid',      '2026-09-05 16:20'),  -- 6
                                                         (3, 'cancelled', '2026-09-06 08:10'),  -- 7
                                                         (3, 'cancelled', '2026-10-15 20:45'),  -- 8
                                                         (4, 'paid',      '2026-10-10 12:00'),  -- 9
                                                         (4, 'paid',      '2026-10-28 19:30'),  -- 10
                                                         (4, 'paid',      '2026-11-05 10:00'),  -- 11
                                                         (5, 'pending',   '2026-11-08 15:15'),  -- 12
                                                         (6, 'paid',      '2026-09-30 23:59'),  -- 13
                                                         (6, 'cancelled', '2026-10-31 13:00'),  -- 14
                                                         (1, 'paid',      '2026-11-09 09:45');  -- 15

INSERT INTO order_items (order_id, product_id, qty, unit_price) VALUES
                                                                    (1, 1, 1, 1750.00), (1, 2, 2, 25.00),
                                                                    (2, 4, 1, 45.00),   (2, 5, 3, 18.00),
                                                                    (3, 3, 1, 120.00),
                                                                    (4, 6, 1, 210.00),  (4, 7, 2, 30.00),
                                                                    (5, 2, 1, 25.00),
                                                                    (6, 3, 2, 110.00),  (6, 4, 1, 45.00),
                                                                    (7, 1, 1, 1800.00),
                                                                    (8, 7, 4, 30.00),
                                                                    (9, 5, 2, 18.00),
                                                                    (10, 6, 1, 199.00), (10, 2, 1, 25.00),
                                                                    (11, 4, 2, 40.00),
                                                                    (12, 3, 1, 120.00),
                                                                    (13, 1, 1, 1800.00), (13, 3, 1, 115.00),
                                                                    (14, 7, 1, 30.00),
                                                                    (15, 5, 1, 18.00),  (15, 7, 3, 28.00);