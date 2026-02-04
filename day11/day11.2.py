# sales_df["month"] = sales_df["date"].astype(str).str[:7]

# monthly_store_rev = (
#     sales_df.groupby(["month", "store_id", "store_name"], as_index=False)["dollar_sales"]
#             .sum()
#             .rename(columns={"dollar_sales": "total_revenue"})
# )

# top3_per_month = (
#     monthly_store_rev.sort_values(["month", "total_revenue"], ascending=[True, False])
#                      .groupby("month", as_index=False)
#                      .head(3)
#                      .reset_index(drop=True)
# )

# print(top3_per_month)

import pandas as pd

sales_df = pd.read_parquet("customer_reviews_with_sentiment.parquet", engine="fastparquet")
sales_df.head()

print(sales_df.info())

sorted_data = sales_df[["product_title", "star_rating", "sentiment", "review_headline", "review_body"]].sort_values(by = "star_rating",ascending=False)[0:10]
print(sorted_data)
