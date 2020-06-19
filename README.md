# Inventory Valuation by Warehouse
This SQL Query is to build the base table for inventory valuation by warehouse.

## Core Idea
Zoho Inventory does not yet have a report for Inventory Valuation by Warehouse. Many businesses need a feature like this and currently it can only be done by syncing the Finance Suite to Analytics and building the report via SQL queries. This query builds the base report (inventory totals by warehouse) to which you can then add item prices and aggregate valuations.

## Configuration
First, in the "Data Sources" tab in Analytics, set up the sync with the Finance Suite. This includes Inventory, Books, and others, but those two are key. The table names that come through in the sync are normally pretty general and this code should be easily adaptable, if not correct already. 

### Things to Note
Essentially, what this query does is create a list of *any* entry in the entire system that affected the Inventory in any warehouse. Different businesses may want to account for inventory differently. Here, inventory is counted once a purchase order *is received* (the first query). Then, it goes through a series of queries that calculate opening stock, credit items in or out, Invoiced items (out), adjustments between warehouses, and sales orders (committed stock, but not yet out). This is just one long list, which can then be aggregated in a summary table, or better synthesized in another SQL query that also brings in item prices.

In this Query, no table aliases are given. Zoho does allow this. Instead of using the `"table_name"."column"` form, you may rename a table after the `FROM` clause, like
`FROM "Purchase Orders" po` and then call it up in a `SELECT` command like `po."Purchase Order ID"`

