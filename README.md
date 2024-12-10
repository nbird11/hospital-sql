# Hospital Management System

## UI to SQL Query Mapping

This document maps the relationships between User Interface (UI) forms and their corresponding SQL operations in the Hospital Management System.

### Read Operations

| UI Form                                                                                             | SQL Query     | Description                                                              |
| --------------------------------------------------------------------------------------------------- | ------------- | ------------------------------------------------------------------------ |
| [Patient History Form](https://nbird11.github.io/hospital-sql/patient-info.html#patientHistoryForm) | 13_RUD.sql:31 | Retrieves complete treatment history for a patient including medications |
| [Doctor Schedule Form](https://nbird11.github.io/hospital-sql/patient-info.html#doctorScheduleForm) | 13_RUD.sql:84 | Shows upcoming appointments for a specific doctor                        |
| [Unpaid Bills Form](https://nbird11.github.io/hospital-sql/patient-info.html#unpaidBillsForm)       | 13_RUD.sql:64 | Generates report of all unpaid bills with patient details                |

### Update Operations

| UI Form                                                                                              | SQL Query      | Description                                                 |
| ---------------------------------------------------------------------------------------------------- | -------------- | ----------------------------------------------------------- |
| [Update Appointment Form](https://nbird11.github.io/hospital-sql/updates.html#updateAppointmentForm) | 13_RUD.sql:124 | Updates status of appointment (completed/cancelled/no-show) |
| [Update Bill Form](https://nbird11.github.io/hospital-sql/updates.html#updateBillForm)               | 13_RUD.sql:141 | Records payment against existing bill                       |
| [Update Medication Form](https://nbird11.github.io/hospital-sql/updates.html#updateMedicationForm)   | 13_RUD.sql:156 | Updates medication inventory quantities                     |

### Delete Operations

| UI Form                                                                                                           | SQL Query      | Description                                                    |
| ----------------------------------------------------------------------------------------------------------------- | -------------- | -------------------------------------------------------------- |
| [Delete Cancelled Form](https://nbird11.github.io/hospital-sql/maintenance.html#deleteCancelledForm)              | 13_RUD.sql:171 | Removes old cancelled appointments                             |
| [Delete Room Assignments Form](https://nbird11.github.io/hospital-sql/maintenance.html#deleteRoomAssignmentsForm) | 13_RUD.sql:189 | Cleans up expired room assignments                             |
| [Delete Unused Meds Form](https://nbird11.github.io/hospital-sql/maintenance.html#deleteUnusedMedsForm)           | 13_RUD.sql:204 | Removes medications with zero stock that were never prescribed |

Note: Create operations are handled through database setup scripts and are not represented in the UI.

## License

This project is licensed under the MIT License with an Academic Acknowledgment clause - see the [LICENSE](LICENSE) file for details.

- SQL files were created as coursework for BYU-Idaho's ITM 220 course
- Web interface (HTML, CSS, JS) is independent work not required by the course
- Any academic use must comply with [BYU-Idaho's Honor Code](https://www.byui.edu/student-honor-office/ces-honor-code) including but not limited to their [Academic Honesty Policy](https://www.byui.edu/student-honor-office/academic-honesty)

## Author

Nathan Bird  
[nathanbirdka@gmail.com](mailto:nathanbirdka@gmail.com)
