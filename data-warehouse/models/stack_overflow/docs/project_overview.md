# Stack Overflow Analytics Overview

## Scope

- **Dataset window:** Questions span from `2008-08-01 00:00:00 UTC` through `2022-09-01 00:00:00 UTC`. All modeling and reporting treat this span as the universe of observed events.
- **Objective:** Surface tags/topics that receive steadily increasing attention (views/scores) yet remain unanswered, so subject experts can prioritize where to respond first.

## Modeling Story

1. **Bronze layer** preserves the raw `posts_questions` and `tags` tables from the public dataset, fully enumerating every column (no `SELECT *`) and partitioning by month for performance.
2. **Silver models** (`stg_questions`, `stg_tags`, `stg_question_tag_bridge`) canonicalize the source keys, explode tags, and ensure the many-to-many relationship is captured.
3. **Gold layer** builds dimensional tables (`dim_questions`, `dim_tags`, `dim_question_tag_bridge`) with surrogate keys, then a fact (`fct_tags_stats_monthly`) that aggregates unanswered question counts, view/score averages, and 1/3/6-month deltas per tag/month. This fact feeds both the storytelling KPI tiles and Looker Studio visuals.
4. Conditional formatting and delta-driven filters only work because the fact relies on a proper star model (questions + tags + bridge), making it easy to slice by time, tag, and delta column without hand-coded SQL in Looker.

## Findings & Caveats

- **Tag coverage gap:** Nearly 10 million unanswered questions do not survive the tag bridge—these appear as `tag_name = "untagged"` in the fact. That suggests the `tags` table is either stale (only covers the top ~10% of tags) or we deliberately capture only the most important tags while leaving the rest untagged. Either way, the bridging approach let us surface the gap analytically.
- **Temporal insight:** The monthly fact tracks creation dates and deltas, so dashboard controls can order by whichever window (1/3/6 months) you select and highlight the hottest tags accordingly.
- **Dashboard design:** Scorecards show total questions, unanswered questions, and the proportion that have tag topics. The top-twenty tables are filtered by selected deltas, and the monthly time-series aligns with the same tag set. Conditional formatting highlights increases/decreases dynamically, while the monthly fact powers pie charts and ratio calculations.

## Looker Studio Recipe

1. Use `fct_tags_stats_monthly` as the source for the top-twenty table and trend chart.  
2. Add a dropdown control that switches between `delta_1m_view`, `delta_3m_view`, `delta_6m_view`, etc., and drive the table ranking via a CASE metric in Looker Studio.  
3. Include conditional formatting on the delta column so positive changes are highlighted in green and drops in red.  
4. Bind the dropdown to the time series so the same tag set is filtered when comparing month-over-month ratios, and use the `creation_month` dimension for the axis.  
5. Separate scorecards display total volume, unanswered total, and how many of those unanswered rows belonged to tagged questions, so viewers understand the proportions at a glance.

This combination of dbt modeling and dashboard controls ensures the story is data-driven, reproducible, and responsive to the metric and time window you care about.

