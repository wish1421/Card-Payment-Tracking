# Card Payment Tracking

The **Card Payment Tracking** project is designed to facilitate the analysis of online payment transactions through comprehensive dashboards. The main goal is to identify promising types of online purchases and customer regions. This project gathers data from the **Credit** database and an Excel file named **charges**.

## Objectives and Deliverables

### Needs
The project aims to develop reporting solutions that allow for:

- Daily and monthly analysis of payments by category and customer region.
- Monthly payment analysis by gender and category.
- Identification of categories and suppliers with the highest payment amounts per month.
- Analysis of monthly payment evolution and establishment of a KPI to increase sales by 10%.

  - **KPI Standards**
    - **Good**: If the objective is met.
    - **Medium**: If 90% of the objective is achieved.
    - **Poor**: Otherwise.

### Display Requirements
- All reports should be aggregated into dashboards with capabilities for both detailed and aggregated views.
- The dashboards should include graphs for a summarized view of the results and allow data filtering by date, category, and region.
- Reports should highlight daily payments over $4,000 and color code daily payments exceeding $400,000.

### Reporting Constraints
- Data for payment amounts will be sourced from the "charge" table and "charges" file.
- Supplier and company names in the reports will be stripped of any prefixes.
- Gender should be displayed as "Female" for True and "Male" for False in the reports.
- Report dates should be displayed without time (short date format), and months should be sorted numerically.

### Additional Features
- Include toggle buttons to show or hide columns.
- Provide functionalities for comparative analysis between the results of the current month and the previous month.

## Development Requirements
- The ETL processes are to be deployed on an SSIS server.
- Data warehouse updates should occur nightly.
- Reporting data should come from an OLAP cube, with cube updates managed via the project's ETL.

## Result Interpretation
- Reports should include an interpretation of the results to assess how the system will assist and enhance business operations.

## Data Sources

- **Database**: Credit
- **Excel File**: charges

## Reporting Deployment
- All reports will be deployed on the reporting server.
