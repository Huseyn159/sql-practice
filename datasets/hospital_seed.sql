
CREATE TABLE specialties (
                             id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                             name   VARCHAR(50) NOT NULL UNIQUE,
                             floor  SMALLINT NOT NULL CHECK (floor BETWEEN 1 AND 10)
);

CREATE TABLE doctors (
                         id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                         full_name     VARCHAR(100) NOT NULL,
                         specialty_id  BIGINT NOT NULL REFERENCES specialties (id),
                         mentor_id     BIGINT REFERENCES doctors (id)
);

CREATE TABLE patients (
                          id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                          full_name  VARCHAR(100) NOT NULL,
                          fin        CHAR(7) NOT NULL UNIQUE,
                          phone      VARCHAR(20)
);

CREATE TABLE visits (
                        id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        patient_id  BIGINT NOT NULL REFERENCES patients (id),
                        doctor_id   BIGINT NOT NULL REFERENCES doctors (id),
                        visit_date  DATE NOT NULL
);

CREATE TABLE diagnoses (
                           id    BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                           name  VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE visit_diagnoses (
                                 visit_id      BIGINT NOT NULL REFERENCES visits (id) ON DELETE CASCADE,
                                 diagnosis_id  BIGINT NOT NULL REFERENCES diagnoses (id),
                                 PRIMARY KEY (visit_id, diagnosis_id)
);

INSERT INTO specialties (name, floor) VALUES
                                          ('Kardiologiya', 3),   -- 1
                                          ('Nevrologiya', 2),    -- 2
                                          ('Terapiya', 1),       -- 3
                                          ('Dermatologiya', 4);  -- 4  (bu ixtisasda həkim yoxdur)

INSERT INTO doctors (full_name, specialty_id, mentor_id) VALUES
                                                             ('Dr. Rauf Kərimov',     1, NULL),  -- 1
                                                             ('Dr. Aysel Səfərova',   2, NULL),  -- 2
                                                             ('Dr. Tural Həsənli',    1, 1),     -- 3  mentoru: Kərimov
                                                             ('Dr. Günel Abbasova',   3, 1),     -- 4  mentoru: Kərimov (başqa ixtisasdan)
                                                             ('Dr. Orxan Məmmədli',   2, 2),     -- 5  mentoru: Səfərova
                                                             ('Dr. Lalə Quliyeva',    3, 4);     -- 6  mentoru: Abbasova (ziyarəti yoxdur)

INSERT INTO patients (full_name, fin, phone) VALUES
                                                 ('Nigar Əliyeva',     '5ABC123', '0551112233'),  -- 1
                                                 ('Rəşad Quliyev',     '7XYZ789', '0504445566'),  -- 2
                                                 ('Elvin Hüseynov',    '3KLM456', NULL),          -- 3
                                                 ('Səbinə Kərimova',   '9PQR321', '0707778899'),  -- 4
                                                 ('Patrick O''Brien',  '2DEF654', '0509990011'),  -- 5
                                                 ('Leyla Məmmədova',   '4GHI987', '0553334455'),  -- 6  (ziyarəti yoxdur)
                                                 ('Kamran Rzayev',     '6JKL147', NULL),          -- 7  (ziyarəti yoxdur)
                                                 ('Aynur Qasımova',    '8MNO258', '0512223344');  -- 8

INSERT INTO visits (patient_id, doctor_id, visit_date) VALUES
                                                           (1, 1, '2025-05-10'),  -- 1
                                                           (1, 2, '2025-11-20'),  -- 2
                                                           (2, 1, '2025-03-01'),  -- 3
                                                           (2, 3, '2026-02-15'),  -- 4
                                                           (3, 4, '2025-09-09'),  -- 5
                                                           (4, 1, '2026-01-12'),  -- 6
                                                           (4, 5, '2026-01-12'),  -- 7
                                                           (5, 2, '2026-03-03'),  -- 8
                                                           (5, 4, '2026-04-18'),  -- 9
                                                           (8, 3, '2026-06-01'),  -- 10
                                                           (8, 3, '2026-07-21'),  -- 11
                                                           (1, 3, '2024-12-30'),  -- 12
                                                           (2, 5, '2026-08-08'),  -- 13
                                                           (3, 1, '2026-09-30');  -- 14

INSERT INTO diagnoses (name) VALUES
                                 ('Hipertoniya'),   -- 1
                                 ('Taxikardiya'),   -- 2
                                 ('Aritmiya'),      -- 3
                                 ('Miqren'),        -- 4
                                 ('Qrip'),          -- 5
                                 ('Ekzema');        -- 6

INSERT INTO visit_diagnoses (visit_id, diagnosis_id) VALUES
                                                         (1, 1), (1, 2),
                                                         (2, 4),
                                                         (3, 3),
                                                         (4, 1),
                                                         (5, 5),
                                                         (6, 1), (6, 3),
                                                         (7, 4),
                                                         (8, 4),
                                                         (9, 5),
                                                         (10, 2),
                                                         (11, 1),
                                                         (12, 1),
                                                         (13, 4),
                                                         (14, 3);