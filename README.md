## Introduction

Stack Overflow (https://stackoverflow.com/) is an open community for anyone that codes. It helps members get answers to their toughest coding questions, share knowledge with their coworkers in private, and find their next dream job.

In this exercise we're focused on identifying the topics that are popular and trending but remain unanswered—these signal both opportunity (experts who could respond) and risk (users who might churn elsewhere).

## Deliverables

### 1. dbt Project Repository

📍 **GitHub Repository**: https://github.com/EdwardPasfield/rittman_analytics_stack_overflow

### 2. Google BigQuery Dataset

📍 **BigQuery Dataset**: https://console.cloud.google.com/bigquery?ws=!1m4!1m3!3m2!1srittman-analytics-ed-pasfield!2sdev

**Note**: Dataset is configured with public read access. Anyone can query the tables without authentication. `rittman-analytics-ed-pasfield.dev`

### 3. Data Model Documentation

📍 **Methodology Document**: `data-warehouse/methodology.md`

### 4. Data Studio Dashboard

📍 **Looker Studio Dashboard**: https://lookerstudio.google.com/reporting/c05d8577-4046-4831-948a-03d1422e6221/page/mLkhF/edit


## How dbt + the report answer the question

- **Modeling narrative:** The dbt pipeline ingests the public `posts_questions` and `tags` tables, and builds `dim_questions`, `dim_tags`, and `dim_question_tag_bridge` with surrogate keys plus schema tests. The resulting star schema feeds `fct_tags_stats_monthly`, which counts unanswered questions, averages views/scores, and calculates 1/3/6 month deltas per tag/month. Custom dbt tests validate fact table consistency (averages match sums/counts within tolerance) and enforce referential integrity across dimensions. See `data-warehouse/models/stack_overflow/docs/methodology.md` for the complete dimensional modeling methodology and ERD.

- **Reporting narrative:** Looker Studio consumes `fct_tags_stats_monthly` for scorecards (total questions, unanswered, unanswered-with-tags), a pie chart of topic share, and a delta-driven top-20 table/time-series pair with conditional formatting so the selected 1/3/6 month window runs through every visual.

- **Insight flow:** Together the dbt models and the dashboard provide context (volume and tagging coverage), surface the top tags, and reveal which ones are accelerating in views or scores so stakeholders can prioritize where to respond.

## Usage instructions

### Credentials & environment variables

1. `sa.json` contains the service account credentials needed to query the Stack Overflow public dataset and run dbt/Looker refreshes.
2. Update the `.env` file with the proper project, dataset prefix, and absolute key path, then source it before running dbt:

```
export BQ_PROJECT="rittman-analytics-ed-pasfield"
export DBT_PREFIX="stack_overflow"
export BQ_KEY_PATH="/Users/edwardpasfield/Documents/Projects/rittman_analytics_stack_overflow/sa.json"
```

3. Run `source .env` before executing dbt commands or refreshing the Looker Studio source.
4. Validate the dataset in the BigQuery console: https://console.cloud.google.com/bigquery?ws=!1m4!1m3!3m2!1srittman-analytics-ed-pasfield!2sdev

### Running dbt

1. `cd data-warehouse`
2. `dbt deps`
3. `dbt seed` (if seeds are added later)
4. `dbt build --select stack_overflow`

### Using the Looker Studio report

- Open https://lookerstudio.google.com/reporting/c05d8577-4046-4831-948a-03d1422e6221/page/mLkhF/edit.
- Switch the metric selector to 1/3/6 month views or scores; the top-20 table and the linked time-series will follow that selection.
- Hover over the pie chart or KPI cards to understand how many unanswered rows include tracked tags vs fall into the “untagged” bucket.

## Possible improvements

1. Improve the report controls so you can filter by views, scores, or question counts across the 1/3/6 month windows—adding another fact that pre-aggregates by the chosen metric would make those filters smoother.
2. Model `dim_users` so we can rank the users with the most unanswered questions that still have topic coverage; that list could be handed to customer management for follow-up or deeper investigations.
3. A yearly topic podium or similar based on a combination of all three stats, amount of questions * score * views (or similar)

