# NYC Housing Complaints & Violations Analytics

An end-to-end data analytics pipeline analyzing NYC 311 No-Heat complaints and HPD housing violations to identify complaint trends, enforcement outcomes, resolution times, and repeat-offender buildings.

## Project Overview

This project integrates NYC 311 service request data with HPD housing violation data to better understand how heating complaints translate into housing violations and how outcomes vary across New York City.

The pipeline transforms raw public datasets into analytics-ready models and dashboards for reporting and analysis.

## Tech Stack

- SQL
- Python
- Google BigQuery
- dbt
- Google Cloud Run
- Google Cloud Scheduler
- Looker Studio

## Data Pipeline

NYC Open Data → Python → Google Cloud Run → BigQuery → dbt → Looker Studio

The pipeline includes automated data ingestion, data cleaning, deduplication, dimensional modeling, data quality testing, and dashboard reporting.

## Key Analysis

- Complaint-to-Violation Rate
- Average Violation Resolution Time
- Repeat-Offender Buildings
- Complaint Volume Growth
- Borough and ZIP Code Trends

## Data Sources

- NYC 311 Service Requests
- NYC HPD Housing Maintenance Code Violations

## Repository Structure

`models/` — dbt transformation and analytics models  
`analyses/` — analytical SQL queries  
`macros/` — reusable dbt macros  
`tests/` — data quality tests  
`seeds/` — reference data

## Dashboard

Interactive dashboards were developed in Looker Studio to visualize housing complaint trends, violations, resolution performance, and geographic patterns across NYC.

### [View Interactive Looker Studio Dashboard](https://datastudio.google.com/s/gG0qaAlzQ1c)
