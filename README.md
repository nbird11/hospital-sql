# Hospital Management System - UI to SQL Query Mapping

This document maps the relationships between User Interface (UI) forms and their corresponding SQL operations in the Hospital Management System.

## Read Operations
| UI Form | SQL Query | Description |
|---------|-----------|-------------|
| patient-info.html#patientHistoryForm | 13_RUD.sql:31 | Retrieves complete treatment history for a patient including medications |
| patient-info.html#unpaidBillsForm | 13_RUD.sql:64 | Generates report of all unpaid bills with patient details |
| patient-info.html#doctorScheduleForm | 13_RUD.sql:84 | Shows upcoming appointments for a specific doctor |

## Update Operations
| UI Form | SQL Query | Description |
|---------|-----------|-------------|
| updates.html#updateAppointmentForm | 13_RUD.sql:124 | Updates status of appointment (completed/cancelled/no-show) |
| updates.html#updateBillForm | 13_RUD.sql:141 | Records payment against existing bill |
| updates.html#updateMedicationForm | 13_RUD.sql:156 | Updates medication inventory quantities |

## Delete Operations
| UI Form | SQL Query | Description |
|---------|-----------|-------------|
| maintenance.html#deleteCancelledForm | 13_RUD.sql:171 | Removes old cancelled appointments |
| maintenance.html#deleteRoomAssignmentsForm | 13_RUD.sql:189 | Cleans up expired room assignments |
| maintenance.html#deleteUnusedMedsForm | 13_RUD.sql:204 | Removes medications with zero stock that were never prescribed |

Note: Create operations are handled through database setup scripts and are not represented in the UI. 