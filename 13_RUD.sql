-- -----------------------------------------------------
-- Hospital Database RUD (No Create)
-- 
-- Contents:
--   [R]ead - Selects:
--     1. Patient's complete treatment history
--     2. Unpaid bills report
--     3. Doctor's upcoming appointments
--   [U]pdate - Updates:
--     1. Update appointment status
--     2. Update bill payment
--     3. Update medication stock
--   [D]elete - Deletes:
--     1. Delete cancelled appointments
--     2. Delete expired room assignments
--     3. Delete unused medications
-- 
-- Author:
--   Nathan Bird (bir19004@byui.edu)
-- -----------------------------------------------------

USE hospital;

-- -----------------------------------------------------
-- [R]ead
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Find patient's complete treatment history
--
-- Real-world use: Doctor reviewing patient history
-- including past diagnoses, treatments, and medications
-- -----------------------------------------------------
SELECT    t.treatment_id
,         t.date
,         t.diagnosis
,         t.details
,         CONCAT(doc.first_name, ' ', doc.last_name) AS doctor_name
,         m.name AS medication_name
,         dsg.dosage
,         freq.frequency
,         dur.duration
FROM      treatment t
JOIN      person doc     ON t.doctor_id     = doc.person_id
LEFT JOIN prescription p ON t.treatment_id  = p.treatment_id
LEFT JOIN medication m   ON p.medication_id = m.medication_id
LEFT JOIN dosage dsg     ON p.dosage_id     = dsg.dosage_id
LEFT JOIN frequency freq ON p.frequency_id  = freq.frequency_id
LEFT JOIN duration dur   ON p.duration_id   = dur.duration_id
WHERE     t.patient_id = (
  SELECT person_id
  FROM   person
  WHERE  first_name = "Daniel"  -- Patient name here
  AND    last_name  = "Miller"
)
ORDER BY  t.date DESC;

-- -----------------------------------------------------
-- Find all patients with unpaid bills
--
-- Real-world use: Financial department following up
-- on outstanding payments
-- -----------------------------------------------------
SELECT CONCAT(p.first_name, ' ', p.last_name) AS patient_name
,      b.treatment_id
,      t.diagnosis
,      b.date
,      b.total
,      b.paid_amount
,      (b.total - b.paid_amount) AS balance_due
FROM   bill b
JOIN   person p ON b.patient_id = p.person_id
JOIN   treatment t ON b.treatment_id = t.treatment_id
WHERE  b.paid_amount < b.total
ORDER BY b.date DESC;

-- -----------------------------------------------------
-- Find upcoming appointments for specific doctor
-- 
-- Real-world use: Doctor checking their daily/weekly
-- schedule of patient appointments
--
-- Note: In production, we'd use NOW() instead of a hardcoded date,
-- but using '2024-03-19' here to match our sample data
-- -----------------------------------------------------
SELECT   a.appointment_id
,        CONCAT(p.first_name, ' ', p.last_name) AS patient_name
,        a.datetime
,        a.reason
,        s.status
,        CONCAT(addr.address_1, 
           CASE WHEN addr.address_2 IS NOT NULL 
		         THEN CONCAT(', ', addr.address_2) 
             ELSE ''
		       END,
           ', ', addr.city, ', ', addr.state) AS patient_address
,        p.phone
FROM     appointment a
JOIN     person p ON a.patient_id = p.person_id
JOIN     status s ON a.status_id = s.status_id
JOIN     person_has_address pha ON p.person_id = pha.person_id
JOIN     address addr ON pha.address_id = addr.address_id
WHERE    a.doctor_id = (
  SELECT   p.person_id
  FROM     person p
  WHERE    p.first_name = "Sarah"  -- Doctor name here
  AND      p.last_name  = "Chen"
)
AND      pha.current = 1
AND      a.datetime >= '2024-03-19'  -- Would use NOW() in production
ORDER BY a.datetime ASC;

-- -----------------------------------------------------
-- [U]pdate
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Update appointment status
--
-- Real-world use: Receptionist marking patient as 
-- arrived/completed/no-show
-- -----------------------------------------------------
UPDATE appointment 
SET    status_id = (SELECT status_id FROM status WHERE status = 'Completed')
WHERE  appointment_id = (
  SELECT a.appointment_id
  FROM (SELECT * FROM appointment) a  -- Derived table to avoid update error
  JOIN person p ON a.patient_id = p.person_id
  WHERE p.email = 'john.smith@email.com'
  AND   a.datetime = '2024-03-20 09:00:00'
);

-- -----------------------------------------------------
-- Update bill with new payment
--
-- Real-world use: Recording a payment made by patient
-- -----------------------------------------------------
UPDATE bill
SET    paid_amount = paid_amount + 150.00  -- Adding payment to existing amount
WHERE  treatment_id = (
  SELECT t.treatment_id
  FROM treatment t
  JOIN person p ON t.patient_id = p.person_id
  WHERE p.email = 'dmiller@email.com'
  AND   t.diagnosis = 'Knee Osteoarthritis'
);

-- -----------------------------------------------------
-- Update medication stock quantity
--
-- Real-world use: Updating inventory after receiving
-- new shipment or dispensing medication
-- -----------------------------------------------------
UPDATE medication
SET    stock_quantity = stock_quantity - 30  -- Reducing stock after dispensing
WHERE  name = 'Lisinopril'
AND    stock_quantity >= 30;  -- Prevent negative stock

-- -----------------------------------------------------
-- [D]elete
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Delete cancelled appointments
--
-- Real-world use: Cleaning up cancelled appointments 
-- older than X days that have no associated treatments
-- -----------------------------------------------------
-- @param cleanup_date: Specific date to clean up before (e.g. '2024-03-01')
-- @param cleanup_days: Number of days back to clean up (e.g. 30)
DELETE FROM appointment
WHERE status_id = (SELECT status_id FROM status WHERE status = 'Cancelled')
AND (
  -- Use specific date if provided, otherwise use days back
  CASE 
    WHEN @cleanup_date IS NOT NULL THEN datetime < @cleanup_date
    ELSE datetime < DATE_SUB(CURRENT_DATE(), INTERVAL @cleanup_days DAY)
  END
)
AND appointment_id NOT IN (
  SELECT a.appointment_id 
  FROM (SELECT * FROM appointment) a
  JOIN treatment t ON a.patient_id = t.patient_id 
  WHERE DATE(a.datetime) = t.date
);

-- -----------------------------------------------------
-- Delete expired room assignments
--
-- Real-world use: Cleaning up room assignment history
-- that's beyond retention requirements
-- -----------------------------------------------------
DELETE FROM overnight_room_assignment
WHERE end < '2024-01-01'  -- Would typically be DATE_SUB(NOW(), INTERVAL 1 YEAR)
AND   assignment_id NOT IN (
  SELECT ora.assignment_id
  FROM (SELECT * FROM overnight_room_assignment) ora
  JOIN treatment t ON ora.person_id = t.patient_id
  WHERE DATE(ora.start) = t.date
);

-- -----------------------------------------------------
-- Delete unused medication records
--
-- Real-world use: Removing discontinued medications
-- that were never prescribed
-- -----------------------------------------------------
DELETE FROM medication
WHERE stock_quantity = 0
AND   medication_id NOT IN (
    SELECT medication_id 
    FROM prescription
);

