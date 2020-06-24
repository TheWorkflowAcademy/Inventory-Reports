#Inventory Reporting in Zoho Analytics
These 2 SQL Queries are to build an inventory valuation report by warehouse, but they can be easily adapted to run just about any kind of Inventory Report you need.

## Core Idea
Zoho Inventory does not yet have a report for Inventory Valuation by Warehouse. Many businesses need a feature like this and currently it can only be done by syncing the Finance Suite to Analytics and building the report via SQL queries. The `warehouse-inventory-count.sql` query builds the base report. Then, you can add in pricing information and extra functionality using the second query, `warehouse-valuation.sql`

## Configuration
First, in the "Data Sources" tab in Analytics, set up the sync with the Finance Suite. This includes Inventory, Books, and others, but those two are key. The table names that come through in the sync are normally pretty general and this code should be easily adaptable, if not correct already. 

### Things to Note
Essentially, what the `warehouse-inventory-count.sql` query does is create a list of *every* entry in the entire system that affected the Inventory in any warehouse. Different businesses may want to account for inventory differently. Here, inventory is counted once a purchase order *is received* (the first `SELECT` query). Then, it goes through a series of queries that calculate opening stock, credit items in or out, Invoiced items (out), adjustments between warehouses, and sales orders (committed stock, but not yet out). This is just one long list, which can then be aggregated and better summarized using the next Query, `warehouse-valuation.sql`

In the first Query, no table aliases are given. Zoho does allow this. Instead of using the `"table_name"."column"` form, you may rename a table after the `FROM` clause, like
`FROM "Purchase Orders" po` and then call it up in a `SELECT` command like `po."Purchase Order ID"`

### To Implement
Use the `warehouse-inventory-count.sql` to create the base table. Then, use `warehouse-valuation.sql` on top of that to bring in the cost and price information, aggregate inventory totals by Item (SKU), and create a better-looking finished product with which you can create nice graphics and reports. Again, the table names are pretty general but should also be easily adaptable and understood.

### Bonus Reports
Once you have a base report of all your inventory, think of all the other cool dashboards you could build! With the `Items` info joined in, you can also filter by Preferred Vendor, by Customers, Commissionable vs. Non-Commissionable, etc. You could make charts showing which items move around the most or are sold the quickest. The specific use-case for these two SQL queries is an inventory valuation by warehouse, but these tables provide the capability to build so many more useful reports!
