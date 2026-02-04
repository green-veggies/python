import getpass
import mysql.connector

host = "localhost"
port = 3306
database = "retail_db"

user = input("MySQL username: ")

conn = mysql.connector.connect(
    host=host,
    port=port,
    user=user,
    password="",
    database=database
)

# print("Connected successfully.")

# def run_query(sql: str, params=None, max_rows: int = 20):
#     cur = conn.cursor()
#     cur.execute(sql, params or ())
#     rows = cur.fetchmany(max_rows)
#     cols = [d[0] for d in cur.description] if cur.description else []
#     cur.close()
#     return cols, rows

# cols, rows = run_query("SELECT * FROM orders LIMIT 10;")

# print(cols)
# for r in rows:
#     print(r)


import pandas as pd

sales_df = pd.read_json("LA_Retail_Sales.json", lines=True)


sales_df["month"] = sales_df["date"].astype(str).str[:7]

monthly_store_rev = (
    sales_df.groupby(["month", "store_id", "store_name"], as_index=False)["dollar_sales"]
            .sum()
            .rename(columns={"dollar_sales": "total_revenue"})
)

top3_per_month = (
    monthly_store_rev.sort_values(["month", "total_revenue"], ascending=[True, False])
                     .groupby("month", as_index=False)
                     .head(3)
                     .reset_index(drop=True)
)

print(top3_per_month)

