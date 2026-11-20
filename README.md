# StreamFlix — Content Analytics
An end-to-end data analytics project analysing subscriber behaviour, content performance, viewing engagement, customer satisfaction, and content investment for a fictional subscription-based streaming platform.

The project covers the complete analytics workflow: data cleaning → exploratory data analysis → SQL KPI analysis → Power BI dashboard and management reporting.
## Project at a Glance
### Project Metric	Result
Subscribers analysed	~15,000
Content titles	~9,000
Viewing records	~650,000
Total watch time	3.33 million hours
Active subscriber rate	74.66%
Churn rate	25.34%
Average completion rate	65.31%
Monthly recurring revenue (MRR)	$175.87K
Average title rating	3.55
Positive review sentiment	68.19%
Watchlist conversion rate	46.23%
Original content share of watch hours	27.17%


Figures are taken from the project's Phase 4 Management Summary Report. Approximate counts are marked with ~.
## Project Objectives
- Measure subscriber activity and churn.
- Understand viewing behaviour across genres, content types, countries, and devices.
- Identify high-performing titles and content categories.
- Evaluate subscription revenue and subscriber plan distribution.
- Analyse ratings, review sentiment, and watchlist conversion.
- Assess the viewing contribution of original content and support content-investment decisions.
## Visual Highlights
Monthly Viewing Activity

Monthly Watch-Hours Trend

Genre-wise Watch-Hours Share

Viewing by Content Type

Top Countries by Watch Hours

Review Sentiment

## Key Business Findings
### Subscriber engagement and retention
- The platform has approximately 15,000 subscribers, with around 11,000 active subscribers.
- The active subscriber rate is 74.66% and churn rate is 25.34%.
- Total viewing time is approximately 3.33 million hours.
- Average completion rate is 65.31%, above the project's 60% target.
## Content performance
The leading genres by watch hours are:
Genre	Watch Hours
Drama	0.50M
Comedy	0.42M
Action	0.39M
Thriller	0.31M
Documentary	0.29M


Drama generates the highest watch time, followed by Comedy and Action. Average completion rates across genres range from approximately 64.81% to 66.83%.
Subscriber and revenue insights
Subscription Plan	Share of Subscribers
Standard	40.67%
Basic With Ads	29.72%
Premium	29.61%


The largest subscriber markets reported are the United States (3.8K), India (1.9K), United Kingdom (1.3K), South Korea (1.1K), and Japan (0.8K). Monthly recurring revenue is approximately USD 175.87K.
## Customer experience and content investment
- Positive review sentiment is 68.19%, with an average rating of 3.55.
- Watchlist conversion is 46.23%.
- Original titles contribute 27.17% of total watch hours.
- Smart TV is the most widely used viewing device.
## Project Workflow
### Phase 1 — Data Cleaning and Quality Checks
#### Notebook: Phase1_DataCleaning_Kajal_Rajak.ipynb
- Loaded and profiled six related datasets.
- Checked missing values, data types, exact duplicates, and primary-key duplicates.
- Standardised and validated data fields.
- Performed data quality and relationship checks.
- Exported cleaned datasets and quality-check reports.
## Phase 2 — Exploratory Data Analysis
#### Notebook: Phase2_EDA_Kajal_Rajak.ipynb

Explored viewing trends, genre performance, content types, country-level viewing, subscriber plans, device usage, subscriber age, completion rates, and review sentiment. Created 10 visualisations using Matplotlib and Seaborn; the exported charts are available in the charts/ folder.
## Phase 3 — SQL KPI Analysis
#### SQL file: Phase3_KPI_Kajal_Rajak.sql

Used PostgreSQL to create views for 10 business KPIs:
1. Total Watch Hours
2. Active Subscriber Rate
3. Churn Rate
4. Average Completion Rate
5. Monthly Recurring Revenue (MRR)
6. Average Revenue Per Active User (ARPU)
7. Average Watch Time per Active Subscriber
8. Watchlist Conversion Rate
9. Hit Concentration
10. Originals Share of Watch Hours
The phase also includes cohort retention analysis at 3-, 6-, and 12-month intervals.
## Phase 4 — Power BI Dashboard and Management Report
- Power BI file: Phase4_Dashboard_Kajal_Rajak.pbix
- Management report: Phase4_Report_Kajal_Rajak.pdf
### The Power BI dashboard contains five pages:
1. Engagement Overview — subscriber engagement, churn, completion rate, watch-hours trend, and device usage.
2. Content Performance — genre-wise watch hours, top-performing titles, and completion rates.
3. Subscriber Insights — plan distribution, geographical markets, active subscribers, and recurring revenue.
4. Experience & Satisfaction — device usage, ratings, review sentiment, and watchlist conversion.
5. Catalogue & Investment — original versus licensed content, genre-wise viewing efficiency, and upcoming licence expirations.
A management summary report documents the findings, risks, opportunities, and recommendations.
## Tools and Technologies
- Python: data preparation and analysis
- Pandas, NumPy: data manipulation
- Matplotlib, Seaborn: data visualisation
- Jupyter Notebook: analysis environment
- PostgreSQL, SQL: KPI calculations and cohort retention analysis
- Power BI, DAX: interactive dashboard and measures
## Repository Structure

```text
StreamFlix-Content-Analytics-Project/
│
├── Phase1_DataCleaning_Kajal_Rajak.ipynb
├── Phase2_EDA_Kajal_Rajak.ipynb
├── Phase3_KPI_Kajal_Rajak.sql
├── Phase4_Dashboard_Kajal_Rajak.pbix
├── Phase4_Report_Kajal_Rajak.pdf
└── README.md
```

## Recommendations from the Analysis
- Investigate churn by plan, country, and subscription tenure to identify subscriber groups needing retention support.
- Evaluate content performance against licensing and production costs before making investment decisions.
- Use ratings and review sentiment to identify titles and customer-experience areas that need improvement.
- Continue monitoring Drama, Comedy, and Action because they currently lead watch-hour performance.
- Review upcoming licence expirations alongside historical viewing performance and renewal costs.
## Conclusion
This project demonstrates an end-to-end approach to transforming raw streaming-platform data into business insights. By combining Python-based data preparation and EDA, PostgreSQL KPI analysis, and Power BI reporting, the project examines subscriber retention, viewing engagement, content performance, customer feedback, and content investment.
Project by: Kajal Rajak
Context: Data Analytics Internship — Internmo
