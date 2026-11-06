SELECT v.visit_date,d.full_name,p.full_name
FROM visits v
JOIN doctors d ON v.doctor_id = d.id
JOIN patients p ON v.patient_id = p.id

SELECT d.full_name,sp.name,sp.floor
FROM doctors d
JOIN specialties sp ON d.specialty_id = sp.id

SELECT sp.name,d.full_name
FROM specialties sp
LEFT JOIN doctors d ON d.specialty_id = sp.id


SELECT p.full_name as pasient_adi,v.id as hekime_gelibmi
FROM patients p
LEFT JOIN visits v ON v.patient_id = p.id
WHERE v.id IS NULL

SELECT d.full_name as hekim,v.id as pasient_qebulu
FROM doctors d
LEFT JOIN visits v ON v.doctor_id = d.id
WHERE v.id IS NULL


SELECT d.name as diagnoses,vd.visit_id
FROM diagnoses d
LEFT JOIN visit_diagnoses vd ON vd.diagnosis_id = d.id
WHERE vd.visit_id IS NULL


SELECT p.full_name,d.name,v.visit_date
FROM patients p
         JOIN visits v ON v.patient_id = p.id
         JOIN visit_diagnoses vd ON vd.visit_id = v.id
         JOIN diagnoses d ON vd.diagnosis_id = d.id
WHERE p.full_name = 'Nigar Əliyeva';


SELECT d.full_name,v.visit_date,p.full_name
FROM doctors d
         JOIN specialties s ON d.specialty_id = s.id
         JOIN visits v ON v.doctor_id = d.id
         JOIN patients p ON v.patient_id = p.id
WHERE s.name = 'Kardiologiya' AND v.visit_date >='2026-01-01' AND v.visit_date<'2027-01-01'

SELECT DISTINCT p.full_name,p.fin,d.name
FROM patients p
         JOIN visits v ON v.patient_id = p.id
         JOIN visit_diagnoses vd ON vd.visit_id = v.id
         JOIN diagnoses d ON vd.diagnosis_id = d.id
WHERE d.name = 'Hipertoniya';

SELECT d.full_name as doctor,m.full_name as mentor
FROM doctors d
         LEFT JOIN doctors m ON d.mentor_id = m.id


SELECT p.full_name,v.visit_date
FROM patients p
         LEFT JOIN visits v ON v.patient_id = p.id AND v.visit_date >='2026-01-01' AND v.visit_date <'2027-01-01'

SELECT d.full_name as doctor,m.full_name as mentor,ds.name as doctors_spec,ms.name as mentor_spec
FROM doctors d
         JOIN doctors m ON d.mentor_id = m.id
         LEFT JOIN specialties ds ON d.specialty_id = ds.id
         LEFT JOIN specialties ms ON m.specialty_id = ms.id
WHERE m.specialty_id != d.specialty_id






