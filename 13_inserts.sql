-- -----------------------------------------------------
-- Hospital Database Population Script
-- 
-- Contents (in order of insertion):
--   1. Core Reference Tables
--      - `hospital`.`role` INSERTS
--      - `hospital`.`department` INSERTS
--      - `hospital`.`status` INSERTS
--      - `hospital`.`room_type` INSERTS
--   2. Location Data
--      - `hospital`.`address` INSERTS
--      - `hospital`.`room` INSERTS
--   3. People and Relationships
--      - `hospital`.`person` INSERTS
--      - `hospital`.`person_has_role` INSERTS
--      - `hospital`.`person_has_address` INSERTS
--      - `hospital`.`staff` INSERTS
--   4. Medical Reference Data
--      - `hospital`.`medication` INSERTS
--      - `hospital`.`dosage` INSERTS
--      - `hospital`.`frequency` INSERTS
--      - `hospital`.`duration` INSERTS
--   5. Patient Care Data
--      - `hospital`.`appointment` INSERTS
--      - `hospital`.`treatment` INSERTS
--      - `hospital`.`prescription` INSERTS
--      - `hospital`.`bill` INSERTS
--      - `hospital`.`overnight_room_assignment` INSERTS
-- 
-- Dependencies:
--   Requires 13_forwardEngineer.sql to be run first
--
-- Author:
--   Nathan Bird (bir19004@byui.edu)
-- -----------------------------------------------------

-- =============================================================
-- 1. Core Reference Tables
-- =============================================================

-- Role inserts
INSERT INTO `hospital`.`role` (`role`) VALUES
('Patient'),
('Doctor'),
('Nurse'),
('Administrator'),
('Receptionist'),
('Surgeon');

-- Department inserts
INSERT INTO `hospital`.`department` (`name`, `location`, `phone`) VALUES
('Emergency', 'First Floor, West Wing', '208-555-1001'),
('Surgery', 'Second Floor, East Wing', '208-555-1002'),
('Pediatrics', 'First Floor, East Wing', '208-555-1003'),
('Cardiology', 'Third Floor, West Wing', '208-555-1004'),
('Orthopedics', 'Second Floor, West Wing', '208-555-1005');

-- Status inserts
INSERT INTO `hospital`.`status` (`status`) VALUES
('Scheduled'),
('In Progress'),
('Completed'),
('Cancelled'),
('Rescheduled'),
('No Show');

-- Room Type inserts
INSERT INTO `hospital`.`room_type` (`type`) VALUES
('Single'),
('Double'),
('Suite'),
('ICU'),
('Operating Room');

-- =============================================================
-- 2. Location Data
-- =============================================================

-- Address inserts (30 addresses to match all staff and patients)
INSERT INTO `hospital`.`address` (`address_1`, `address_2`, `city`, `state`, `postal_code`) VALUES
-- Patients addresses (1-5)
('123 S 1st W', 'Apt 4', 'Rexburg', 'ID', '83440'),
('456 W 7th S', NULL, 'Rexburg', 'ID', '83440'),
('789 University Blvd', 'Suite 101', 'Rexburg', 'ID', '83440'),
('321 W 2nd S', NULL, 'Rexburg', 'ID', '83440'),
('654 S Center St', 'Unit 3B', 'Rexburg', 'ID', '83440'),
-- Doctors addresses (6-10)
('987 Pioneer Rd', NULL, 'Rexburg', 'ID', '83440'),
('147 N 2nd E', 'Apt 2A', 'Sugar City', 'ID', '83448'),
('258 E 3rd N', NULL, 'Sugar City', 'ID', '83448'),
('369 Teton Ave', 'Suite 200', 'Sugar City', 'ID', '83448'),
('741 Yellowstone Hwy', NULL, 'Idaho Falls', 'ID', '83401'),
-- Nurses addresses (11-15)
('852 E 17th St', 'Unit 5C', 'Idaho Falls', 'ID', '83401'),
('963 S Boulevard', NULL, 'Idaho Falls', 'ID', '83402'),
('159 W Broadway St', 'Apt 6D', 'Idaho Falls', 'ID', '83402'),
('357 Memorial Dr', NULL, 'Idaho Falls', 'ID', '83402'),
('486 N Holmes Ave', 'Suite 300', 'Idaho Falls', 'ID', '83401'),
-- Receptionists addresses (16-20)
('792 Farnsworth Way', NULL, 'Rigby', 'ID', '83442'),
('135 State St', 'Unit 7E', 'Rigby', 'ID', '83442'),
('246 Main St', NULL, 'Rigby', 'ID', '83442'),
('864 E Main St', 'Apt 8F', 'Ashton', 'ID', '83420'),
('975 N Fremont Ave', NULL, 'St Anthony', 'ID', '83445'),
-- Administrators addresses (21-25)
('753 Park Ave', 'Unit 4C', 'Rexburg', 'ID', '83440'),
('951 College Ave', NULL, 'Rexburg', 'ID', '83440'),
('357 Temple View Dr', 'Apt 5B', 'Rexburg', 'ID', '83440'),
('159 Science Center Dr', NULL, 'Rexburg', 'ID', '83440'),
('753 Viking Dr', 'Suite 102', 'Rexburg', 'ID', '83440'),
-- Surgeons addresses (26-30)
('456 Riverside Ave', NULL, 'Idaho Falls', 'ID', '83402'),
('789 Falls Dr', 'Apt 3C', 'Idaho Falls', 'ID', '83401'),
('321 Mountain View', NULL, 'Rigby', 'ID', '83442'),
('654 Valley Rd', 'Unit 2B', 'Rexburg', 'ID', '83440'),
('987 Highland Dr', NULL, 'Sugar City', 'ID', '83448');

-- Room inserts
INSERT INTO `hospital`.`room` (`number`, `room_type_id`, `capacity`, `available`) VALUES
-- Single rooms
(101, (SELECT room_type_id FROM room_type WHERE type = 'Single'), 1, 1),
(102, (SELECT room_type_id FROM room_type WHERE type = 'Single'), 1, 1),
(103, (SELECT room_type_id FROM room_type WHERE type = 'Single'), 1, 1),
(104, (SELECT room_type_id FROM room_type WHERE type = 'Single'), 1, 1),
-- Double rooms
(201, (SELECT room_type_id FROM room_type WHERE type = 'Double'), 2, 1),
(202, (SELECT room_type_id FROM room_type WHERE type = 'Double'), 2, 1),
(203, (SELECT room_type_id FROM room_type WHERE type = 'Double'), 2, 1),
(204, (SELECT room_type_id FROM room_type WHERE type = 'Double'), 2, 1),
-- Suites
(301, (SELECT room_type_id FROM room_type WHERE type = 'Suite'), 1, 1),
(302, (SELECT room_type_id FROM room_type WHERE type = 'Suite'), 1, 1),
(303, (SELECT room_type_id FROM room_type WHERE type = 'Suite'), 1, 1),
(304, (SELECT room_type_id FROM room_type WHERE type = 'Suite'), 1, 1),
-- ICU rooms
(401, (SELECT room_type_id FROM room_type WHERE type = 'ICU'), 1, 1),
(402, (SELECT room_type_id FROM room_type WHERE type = 'ICU'), 1, 1),
(403, (SELECT room_type_id FROM room_type WHERE type = 'ICU'), 1, 1),
(404, (SELECT room_type_id FROM room_type WHERE type = 'ICU'), 1, 1),
-- Operating rooms
(501, (SELECT room_type_id FROM room_type WHERE type = 'Operating Room'), 1, 1),
(502, (SELECT room_type_id FROM room_type WHERE type = 'Operating Room'), 1, 1),
(503, (SELECT room_type_id FROM room_type WHERE type = 'Operating Room'), 1, 1),
(504, (SELECT room_type_id FROM room_type WHERE type = 'Operating Room'), 1, 1);

-- =============================================================
-- 3. People and Relationships
-- =============================================================

-- Person inserts (At least 5 people per role)
INSERT INTO `hospital`.`person` (`first_name`, `last_name`, `sex`, `date_of_birth`, `phone`, `email`) VALUES
-- Patients (role_id = 1)
-- Addresses (address_id = 1-5)
('John', 'Smith', 'M', '1992-11-21', '208-555-0001', 'john.smith@email.com'),
('Emma', 'Johnson', 'F', '1965-01-07', '208-555-0002', 'emma.j@email.com'),
('Thomas', 'Brown', 'M', '1978-04-24', '208-555-0003', 'tbrown@email.com'),
('Sophie', 'Davis', 'F', '1995-07-31', '208-555-0004', 'sophied@email.com'),
('Daniel', 'Miller', 'M', '1982-10-17', '208-555-0005', 'dmiller@email.com'),
-- Doctors (role_id = 2)
-- Addresses (address_id = 6-10)
('James', 'Wilson', 'M', '1975-03-15', '208-555-0006', 'j.wilson@mvrh.org'),
('Sarah', 'Chen', 'F', '1980-06-22', '208-555-0007', 's.chen@mvrh.org'),
('Michael', 'Peterson', 'M', '1968-09-30', '208-555-0008', 'm.peterson@mvrh.org'),
('Emily', 'Rodriguez', 'F', '1982-12-05', '208-555-0009', 'e.rodriguez@mvrh.org'),
('David', 'Thompson', 'M', '1977-04-18', '208-555-0010', 'd.thompson@mvrh.org'),
-- Nurses (role_id = 3)
-- Addresses (address_id = 11-15)
('Jennifer', 'Clark', 'F', '1985-07-25', '208-555-0011', 'j.clark@mvrh.org'),
('Robert', 'Young', 'M', '1990-10-12', '208-555-0012', 'r.young@mvrh.org'),
('Lisa', 'Anderson', 'F', '1988-02-28', '208-555-0013', 'l.anderson@mvrh.org'),
('William', 'Garcia', 'M', '1983-05-09', '208-555-0014', 'w.garcia@mvrh.org'),
('Maria', 'Martinez', 'F', '1987-08-14', '208-555-0015', 'm.martinez@mvrh.org'),
-- Administrators (role_id = 4)
-- Addresses (address_id = 16-20)
('Patricia', 'Adams', 'F', '1979-06-18', '208-555-0016', 'p.adams@mvrh.org'),
('George', 'Hall', 'M', '1981-09-05', '208-555-0017', 'g.hall@mvrh.org'),
('Nancy', 'Wright', 'F', '1976-12-22', '208-555-0018', 'n.wright@mvrh.org'),
('Kevin', 'Lopez', 'M', '1984-03-09', '208-555-0019', 'k.lopez@mvrh.org'),
('Rachel', 'Hill', 'F', '1988-06-26', '208-555-0020', 'r.hill@mvrh.org'),
-- Receptionists (role_id = 5)
-- Addresses (address_id = 21-25)
('Steven', 'King', 'M', '1991-09-13', '208-555-0021', 's.king@mvrh.org'),
('Laura', 'Scott', 'F', '1983-12-30', '208-555-0022', 'l.scott@mvrh.org'),
('Christopher', 'Green', 'M', '1987-03-17', '208-555-0023', 'c.green@mvrh.org'),
('Michelle', 'Baker', 'F', '1982-06-04', '208-555-0024', 'm.baker@mvrh.org'),
('Brandon', 'Nelson', 'M', '1986-09-21', '208-555-0025', 'b.nelson@mvrh.org'),
-- Surgeons (role_id = 6)
-- Addresses (address_id = 26-30)
('Elizabeth', 'Taylor', 'F', '1972-08-15', '208-555-0026', 'e.taylor@mvrh.org'),
('Richard', 'Lee', 'M', '1969-11-30', '208-555-0027', 'r.lee@mvrh.org'),
('Margaret', 'White', 'F', '1974-04-12', '208-555-0028', 'm.white@mvrh.org'),
('Joseph', 'Harris', 'M', '1971-07-25', '208-555-0029', 'j.harris@mvrh.org'),
('Catherine', 'Martin', 'F', '1976-02-08', '208-555-0030', 'c.martin@mvrh.org');

-- Person has address inserts
INSERT INTO `hospital`.`person_has_address` (`person_id`, `address_id`, `current`) VALUES
-- Patients (addresses 1-5)
((SELECT person_id FROM person WHERE email = 'john.smith@email.com'), 1, 1),
((SELECT person_id FROM person WHERE email = 'emma.j@email.com'), 2, 1),
((SELECT person_id FROM person WHERE email = 'tbrown@email.com'), 3, 1),
((SELECT person_id FROM person WHERE email = 'sophied@email.com'), 4, 1),
((SELECT person_id FROM person WHERE email = 'dmiller@email.com'), 5, 1),
-- Doctors (addresses 6-10)
((SELECT person_id FROM person WHERE email = 'j.wilson@mvrh.org'), 6, 1),
((SELECT person_id FROM person WHERE email = 's.chen@mvrh.org'), 7, 1),
((SELECT person_id FROM person WHERE email = 'm.peterson@mvrh.org'), 8, 1),
((SELECT person_id FROM person WHERE email = 'e.rodriguez@mvrh.org'), 9, 1),
((SELECT person_id FROM person WHERE email = 'd.thompson@mvrh.org'), 10, 1),
-- Nurses (addresses 11-15)
((SELECT person_id FROM person WHERE email = 'j.clark@mvrh.org'), 11, 1),
((SELECT person_id FROM person WHERE email = 'r.young@mvrh.org'), 12, 1),
((SELECT person_id FROM person WHERE email = 'l.anderson@mvrh.org'), 13, 1),
((SELECT person_id FROM person WHERE email = 'w.garcia@mvrh.org'), 14, 1),
((SELECT person_id FROM person WHERE email = 'm.martinez@mvrh.org'), 15, 1),
-- Administrators (addresses 16-20)
((SELECT person_id FROM person WHERE email = 'p.adams@mvrh.org'), 16, 1),
((SELECT person_id FROM person WHERE email = 'g.hall@mvrh.org'), 17, 1),
((SELECT person_id FROM person WHERE email = 'n.wright@mvrh.org'), 18, 1),
((SELECT person_id FROM person WHERE email = 'k.lopez@mvrh.org'), 19, 1),
((SELECT person_id FROM person WHERE email = 'r.hill@mvrh.org'), 20, 1),
-- Receptionists (addresses 21-25)
((SELECT person_id FROM person WHERE email = 's.king@mvrh.org'), 21, 1),
((SELECT person_id FROM person WHERE email = 'l.scott@mvrh.org'), 22, 1),
((SELECT person_id FROM person WHERE email = 'c.green@mvrh.org'), 23, 1),
((SELECT person_id FROM person WHERE email = 'm.baker@mvrh.org'), 24, 1),
((SELECT person_id FROM person WHERE email = 'b.nelson@mvrh.org'), 25, 1),
-- Surgeons (addresses 26-30)
((SELECT person_id FROM person WHERE email = 'e.taylor@mvrh.org'), 26, 1),
((SELECT person_id FROM person WHERE email = 'r.lee@mvrh.org'), 27, 1),
((SELECT person_id FROM person WHERE email = 'm.white@mvrh.org'), 28, 1),
((SELECT person_id FROM person WHERE email = 'j.harris@mvrh.org'), 29, 1),
((SELECT person_id FROM person WHERE email = 'c.martin@mvrh.org'), 30, 1);

-- Person has role inserts
INSERT INTO `hospital`.`person_has_role` (`person_id`, `role_id`) VALUES
-- Patients
((SELECT person_id FROM person WHERE email = 'john.smith@email.com'), 
 (SELECT role_id FROM role WHERE role = 'Patient')),
((SELECT person_id FROM person WHERE email = 'emma.j@email.com'), 
 (SELECT role_id FROM role WHERE role = 'Patient')),
((SELECT person_id FROM person WHERE email = 'tbrown@email.com'), 
 (SELECT role_id FROM role WHERE role = 'Patient')),
((SELECT person_id FROM person WHERE email = 'sophied@email.com'), 
 (SELECT role_id FROM role WHERE role = 'Patient')),
((SELECT person_id FROM person WHERE email = 'dmiller@email.com'), 
 (SELECT role_id FROM role WHERE role = 'Patient')),
-- Doctors
((SELECT person_id FROM person WHERE email = 'j.wilson@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Doctor')),
((SELECT person_id FROM person WHERE email = 's.chen@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Doctor')),
((SELECT person_id FROM person WHERE email = 'm.peterson@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Doctor')),
((SELECT person_id FROM person WHERE email = 'e.rodriguez@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Doctor')),
((SELECT person_id FROM person WHERE email = 'd.thompson@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Doctor')),
-- Nurses
((SELECT person_id FROM person WHERE email = 'j.clark@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Nurse')),
((SELECT person_id FROM person WHERE email = 'r.young@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Nurse')),
((SELECT person_id FROM person WHERE email = 'l.anderson@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Nurse')),
((SELECT person_id FROM person WHERE email = 'w.garcia@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Nurse')),
((SELECT person_id FROM person WHERE email = 'm.martinez@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Nurse')),
-- Administrators
((SELECT person_id FROM person WHERE email = 'p.adams@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Administrator')),
((SELECT person_id FROM person WHERE email = 'g.hall@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Administrator')),
((SELECT person_id FROM person WHERE email = 'n.wright@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Administrator')),
((SELECT person_id FROM person WHERE email = 'k.lopez@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Administrator')),
((SELECT person_id FROM person WHERE email = 'r.hill@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Administrator')),
-- Receptionists
((SELECT person_id FROM person WHERE email = 's.king@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Receptionist')),
((SELECT person_id FROM person WHERE email = 'l.scott@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Receptionist')),
((SELECT person_id FROM person WHERE email = 'c.green@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Receptionist')),
((SELECT person_id FROM person WHERE email = 'm.baker@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Receptionist')),
((SELECT person_id FROM person WHERE email = 'b.nelson@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Receptionist')),
-- Surgeons
((SELECT person_id FROM person WHERE email = 'e.taylor@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Surgeon')),
((SELECT person_id FROM person WHERE email = 'r.lee@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Surgeon')),
((SELECT person_id FROM person WHERE email = 'm.white@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Surgeon')),
((SELECT person_id FROM person WHERE email = 'j.harris@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Surgeon')),
((SELECT person_id FROM person WHERE email = 'c.martin@mvrh.org'), 
 (SELECT role_id FROM role WHERE role = 'Surgeon'));

-- Staff inserts
INSERT INTO `hospital`.`staff` (`person_id`, `department_id`, `currently_employed`) VALUES
-- Doctors in departments
((SELECT person_id FROM person WHERE email = 'j.wilson@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Cardiology'), 1),
((SELECT person_id FROM person WHERE email = 's.chen@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Pediatrics'), 1),
((SELECT person_id FROM person WHERE email = 'm.peterson@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Emergency'), 1),
((SELECT person_id FROM person WHERE email = 'e.rodriguez@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Orthopedics'), 1),
((SELECT person_id FROM person WHERE email = 'd.thompson@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Cardiology'), 1),
-- Nurses in departments
((SELECT person_id FROM person WHERE email = 'j.clark@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Emergency'), 1),
((SELECT person_id FROM person WHERE email = 'r.young@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Surgery'), 1),
((SELECT person_id FROM person WHERE email = 'l.anderson@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Pediatrics'), 1),
((SELECT person_id FROM person WHERE email = 'w.garcia@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Cardiology'), 1),
((SELECT person_id FROM person WHERE email = 'm.martinez@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Orthopedics'), 1),
-- Administrators in departments
((SELECT person_id FROM person WHERE email = 'p.adams@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Cardiology'), 1),
((SELECT person_id FROM person WHERE email = 'g.hall@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Surgery'), 1),
((SELECT person_id FROM person WHERE email = 'n.wright@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Emergency'), 1),
((SELECT person_id FROM person WHERE email = 'k.lopez@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Pediatrics'), 1),
((SELECT person_id FROM person WHERE email = 'r.hill@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Orthopedics'), 1),
-- Receptionists in departments
((SELECT person_id FROM person WHERE email = 's.king@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Cardiology'), 1),
((SELECT person_id FROM person WHERE email = 'l.scott@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Surgery'), 1),
((SELECT person_id FROM person WHERE email = 'c.green@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Emergency'), 1),
((SELECT person_id FROM person WHERE email = 'm.baker@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Pediatrics'), 1),
((SELECT person_id FROM person WHERE email = 'b.nelson@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Orthopedics'), 1),
-- Surgeons in surgery department
((SELECT person_id FROM person WHERE email = 'e.taylor@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Surgery'), 1),
((SELECT person_id FROM person WHERE email = 'r.lee@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Surgery'), 1),
((SELECT person_id FROM person WHERE email = 'm.white@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Surgery'), 1),
((SELECT person_id FROM person WHERE email = 'j.harris@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Surgery'), 1),
((SELECT person_id FROM person WHERE email = 'c.martin@mvrh.org'), 
 (SELECT department_id FROM department WHERE name = 'Surgery'), 1);

-- =============================================================
-- 4. Medical Reference Data
-- =============================================================

-- Medication inserts (20 common medications)
INSERT INTO `hospital`.`medication` (`name`, `description`, `stock_quantity`) VALUES
('Amoxicillin', 'Antibiotic for bacterial infections', 1000),
('Lisinopril', 'ACE inhibitor for high blood pressure', 800),
('Metformin', 'Diabetes medication', 900),
('Omeprazole', 'Acid reflux medication', 750),
('Sertraline', 'Antidepressant medication', 600),
('Albuterol', 'Bronchodilator for asthma', 400),
('Gabapentin', 'Nerve pain medication', 550),
('Metoprolol', 'Beta blocker for heart conditions', 700),
('Levothyroxine', 'Thyroid hormone medication', 850),
('Amlodipine', 'Calcium channel blocker for blood pressure', 600),
('Prednisone', 'Corticosteroid anti-inflammatory', 450),
('Hydrocodone', 'Pain medication', 300),
('Furosemide', 'Diuretic for fluid retention', 500),
('Alprazolam', 'Anti-anxiety medication', 250),
('Azithromycin', 'Antibiotic for infections', 400),
('Ibuprofen', 'Pain and inflammation reliever', 1200),
('Fluoxetine', 'Antidepressant medication', 350),
('Pantoprazole', 'Acid reflux medication', 450),
('Citalopram', 'Antidepressant medication', 300),
('Atorvastatin', 'Cholesterol-lowering medication', 700);

-- Dosage inserts
INSERT INTO `hospital`.`dosage` (`dosage`) VALUES
('1g'),
('2.5mg'),
('5mg'),
('10mg'),
('15mg'),
('20mg'),
('25mg'),
('30mg'),
('40mg'),
('50mg'),
('60mg'),
('75mg'),
('80mg'),
('100mg'),
('120mg'),
('150mg'),
('200mg'),
('250mg'),
('300mg'),
('400mg'),
('500mg');

-- Frequency inserts
INSERT INTO `hospital`.`frequency` (`frequency`) VALUES
('Once daily'),
('Twice daily'),
('Three times daily'),
('Four times daily'),
('Every 4 hours'),
('Every 6 hours'),
('Every 8 hours'),
('Every 12 hours'),
('Weekly'),
('As needed'),
('Before meals'),
('After meals'),
('At bedtime'),
('Every morning'),
('Every evening'),
('Every other day'),
('Twice weekly'),
('Monthly'),
('Every 2 hours'),
('With meals');

-- Duration inserts
INSERT INTO `hospital`.`duration` (`duration`) VALUES
('3 days'),
('5 days'),
('7 days'),
('10 days'),
('14 days'),
('21 days'),
('28 days'),
('30 days'),
('60 days'),
('90 days'),
('6 months'),
('1 year'),
('As needed'),
('Indefinitely'),
('Until finished'),
('2 weeks'),
('3 months'),
('4 months'),
('6 weeks'),
('8 weeks');

-- =============================================================
-- 5. Patient Care Data
-- =============================================================

-- Appointment inserts
INSERT INTO `hospital`.`appointment` (`patient_id`, `doctor_id`, `datetime`, `reason`, `status_id`) VALUES
-- John Smith's annual checkup with Dr. Wilson
((SELECT person_id FROM person WHERE email = 'john.smith@email.com'),
 (SELECT person_id FROM person WHERE email = 'j.wilson@mvrh.org'),
 '2024-03-20 09:00:00',
 'Annual checkup',
 (SELECT status_id FROM status WHERE status = 'Scheduled')),
-- Emma Johnson's blood pressure follow-up with Dr. Chen
((SELECT person_id FROM person WHERE email = 'emma.j@email.com'),
 (SELECT person_id FROM person WHERE email = 's.chen@mvrh.org'),
 '2024-03-20 10:00:00',
 'Blood pressure follow-up',
 (SELECT status_id FROM status WHERE status = 'Scheduled')),
-- Thomas Brown's diabetes management with Dr. Peterson
((SELECT person_id FROM person WHERE email = 'tbrown@email.com'),
 (SELECT person_id FROM person WHERE email = 'm.peterson@mvrh.org'),
 '2024-03-20 11:00:00',
 'Diabetes management',
 (SELECT status_id FROM status WHERE status = 'Scheduled')),
-- Sophie Davis's pregnancy checkup with Dr. Rodriguez
((SELECT person_id FROM person WHERE email = 'sophied@email.com'),
 (SELECT person_id FROM person WHERE email = 'e.rodriguez@mvrh.org'),
 '2024-03-20 14:00:00',
 'Pregnancy checkup',
 (SELECT status_id FROM status WHERE status = 'Completed')),
-- Daniel Miller's knee surgery consultation with Dr. Thompson
((SELECT person_id FROM person WHERE email = 'dmiller@email.com'),
 (SELECT person_id FROM person WHERE email = 'd.thompson@mvrh.org'),
 '2024-03-20 15:30:00',
 'Knee surgery consultation',
 (SELECT status_id FROM status WHERE status = 'Completed')),
-- John Smith's follow-up with Dr. Wilson
((SELECT person_id FROM person WHERE email = 'john.smith@email.com'),
 (SELECT person_id FROM person WHERE email = 'j.wilson@mvrh.org'),
 '2024-03-27 09:00:00',
 'Blood pressure follow-up',
 (SELECT status_id FROM status WHERE status = 'Scheduled')),
-- Emma Johnson's missed appointment with Dr. Chen
((SELECT person_id FROM person WHERE email = 'emma.j@email.com'),
 (SELECT person_id FROM person WHERE email = 's.chen@mvrh.org'),
 '2024-03-19 10:00:00',
 'Diabetes follow-up',
 (SELECT status_id FROM status WHERE status = 'No Show')),
-- Thomas Brown's rescheduled appointment with Dr. Peterson
((SELECT person_id FROM person WHERE email = 'tbrown@email.com'),
 (SELECT person_id FROM person WHERE email = 'm.peterson@mvrh.org'),
 '2024-03-25 14:00:00',
 'Medication review',
 (SELECT status_id FROM status WHERE status = 'Rescheduled')),
-- Sophie Davis's emergency visit with Dr. Rodriguez
((SELECT person_id FROM person WHERE email = 'sophied@email.com'),
 (SELECT person_id FROM person WHERE email = 'e.rodriguez@mvrh.org'),
 '2024-03-19 02:15:00',
 'Pregnancy complications',
 (SELECT status_id FROM status WHERE status = 'Completed')),
-- Daniel Miller's cancelled appointment with Dr. Thompson
((SELECT person_id FROM person WHERE email = 'dmiller@email.com'),
 (SELECT person_id FROM person WHERE email = 'd.thompson@mvrh.org'),
 '2024-03-21 11:30:00',
 'Post-surgery follow-up',
 (SELECT status_id FROM status WHERE status = 'Cancelled'));

-- Treatment inserts
INSERT INTO `hospital`.`treatment` (`patient_id`, `doctor_id`, `date`, `diagnosis`, `details`) VALUES
-- John Smith's hypertension treatment with Dr. Wilson (from completed annual checkup)
((SELECT person_id FROM person WHERE email = 'john.smith@email.com'),
 (SELECT person_id FROM person WHERE email = 'j.wilson@mvrh.org'),
 '2024-03-20',
 'Hypertension',
 'Blood pressure 140/90, prescribed medication'),
-- Emma Johnson's diabetes treatment with Dr. Chen (from completed appointment)
((SELECT person_id FROM person WHERE email = 'emma.j@email.com'),
 (SELECT person_id FROM person WHERE email = 's.chen@mvrh.org'),
 '2024-03-20',
 'Type 2 Diabetes',
 'Blood sugar levels elevated, adjusted medication'),
-- Sophie Davis's pregnancy complication treatment with Dr. Rodriguez (from emergency visit)
((SELECT person_id FROM person WHERE email = 'sophied@email.com'),
 (SELECT person_id FROM person WHERE email = 'e.rodriguez@mvrh.org'),
 '2024-03-19',
 'Threatened Miscarriage',
 'Prescribed bed rest and monitoring, scheduled follow-up'),
-- Sophie Davis's regular pregnancy checkup treatment (from completed checkup)
((SELECT person_id FROM person WHERE email = 'sophied@email.com'),
 (SELECT person_id FROM person WHERE email = 'e.rodriguez@mvrh.org'),
 '2024-03-20',
 'Routine Pregnancy',
 'Week 24 checkup, all measurements normal'),
-- Daniel Miller's knee evaluation with Dr. Thompson (from completed consultation)
((SELECT person_id FROM person WHERE email = 'dmiller@email.com'),
 (SELECT person_id FROM person WHERE email = 'd.thompson@mvrh.org'),
 '2024-03-20',
 'Knee Osteoarthritis',
 'Recommended arthroscopic surgery, provided pre-op instructions');

-- Prescription inserts
INSERT INTO `hospital`.`prescription` (`treatment_id`, `medication_id`, `dosage_id`, `frequency_id`, `duration_id`) VALUES
-- John Smith's blood pressure medication
((SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Hypertension' 
  AND p.email = 'john.smith@email.com'),
 (SELECT medication_id FROM medication WHERE name = 'Lisinopril'),
 (SELECT dosage_id FROM dosage WHERE dosage = '10mg'),
 (SELECT frequency_id FROM frequency WHERE frequency = 'Once daily'),
 (SELECT duration_id FROM duration WHERE duration = '30 days')),
-- Emma Johnson's diabetes medication
((SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Type 2 Diabetes' 
  AND p.email = 'emma.j@email.com'),
 (SELECT medication_id FROM medication WHERE name = 'Metformin'),
 (SELECT dosage_id FROM dosage WHERE dosage = '500mg'),
 (SELECT frequency_id FROM frequency WHERE frequency = 'Twice daily'),
 (SELECT duration_id FROM duration WHERE duration = '90 days')),
-- Sophie Davis's pregnancy complication medications
((SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Threatened Miscarriage' 
  AND p.email = 'sophied@email.com'),
 (SELECT medication_id FROM medication WHERE name = 'Prednisone'),
 (SELECT dosage_id FROM dosage WHERE dosage = '5mg'),
 (SELECT frequency_id FROM frequency WHERE frequency = 'Once daily'),
 (SELECT duration_id FROM duration WHERE duration = '7 days')),
-- Daniel Miller's knee pain medications
((SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Knee Osteoarthritis' 
  AND p.email = 'dmiller@email.com'),
 (SELECT medication_id FROM medication WHERE name = 'Ibuprofen'),
 (SELECT dosage_id FROM dosage WHERE dosage = '400mg'),
 (SELECT frequency_id FROM frequency WHERE frequency = 'Three times daily'),
 (SELECT duration_id FROM duration WHERE duration = 'As needed')),
((SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Knee Osteoarthritis' 
  AND p.email = 'dmiller@email.com'),
 (SELECT medication_id FROM medication WHERE name = 'Gabapentin'),
 (SELECT dosage_id FROM dosage WHERE dosage = '300mg'),
 (SELECT frequency_id FROM frequency WHERE frequency = 'At bedtime'),
 (SELECT duration_id FROM duration WHERE duration = '14 days'));

-- Bill inserts
INSERT INTO `hospital`.`bill` (`patient_id`, `treatment_id`, `date`, `total`, `paid_amount`) VALUES 
-- John Smith's hypertension treatment bill
((SELECT t.patient_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Hypertension' 
  AND p.email = 'john.smith@email.com'),
 (SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Hypertension' 
  AND p.email = 'john.smith@email.com'),
 (SELECT t.date 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Hypertension' 
  AND p.email = 'john.smith@email.com'),
 350.00,
 0.00),
-- Emma Johnson's diabetes treatment bill
((SELECT t.patient_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Type 2 Diabetes' 
  AND p.email = 'emma.j@email.com'),
 (SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Type 2 Diabetes' 
  AND p.email = 'emma.j@email.com'),
 (SELECT t.date 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Type 2 Diabetes' 
  AND p.email = 'emma.j@email.com'),
 275.00,
 0.00),
-- Sophie Davis's emergency pregnancy complication bill
((SELECT t.patient_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Threatened Miscarriage' 
  AND p.email = 'sophied@email.com'),
 (SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Threatened Miscarriage' 
  AND p.email = 'sophied@email.com'),
 (SELECT t.date 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Threatened Miscarriage' 
  AND p.email = 'sophied@email.com'),
 1250.00,
 1250.00),
-- Sophie Davis's routine pregnancy checkup bill
((SELECT t.patient_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Routine Pregnancy' 
  AND p.email = 'sophied@email.com'),
 (SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Routine Pregnancy' 
  AND p.email = 'sophied@email.com'),
 (SELECT t.date 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Routine Pregnancy' 
  AND p.email = 'sophied@email.com'),
 200.00,
 200.00),
-- Daniel Miller's knee consultation bill
((SELECT t.patient_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Knee Osteoarthritis' 
  AND p.email = 'dmiller@email.com'),
 (SELECT t.treatment_id 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Knee Osteoarthritis' 
  AND p.email = 'dmiller@email.com'),
 (SELECT t.date 
  FROM treatment t 
  JOIN person p ON t.patient_id = p.person_id 
  WHERE t.diagnosis = 'Knee Osteoarthritis' 
  AND p.email = 'dmiller@email.com'),
 450.00,
 150.00);

-- Overnight Room Assignment inserts
INSERT INTO `hospital`.`overnight_room_assignment` (`person_id`, `room_id`, `start`, `end`) VALUES 
-- John Smith's overnight stay
((SELECT person_id FROM person WHERE email = 'john.smith@email.com'),
 (SELECT room_id FROM room WHERE number = 101),
 '2024-03-20 18:00:00',
 '2024-03-21 11:00:00'),
-- Emma Johnson's overnight stay
((SELECT person_id FROM person WHERE email = 'emma.j@email.com'),
 (SELECT room_id FROM room WHERE number = 102),
 '2024-03-20 14:00:00',
 '2024-03-21 10:00:00');
 