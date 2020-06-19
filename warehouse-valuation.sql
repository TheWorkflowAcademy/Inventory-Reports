SELECT
		 i."Item Name" as 'Item Name',
		 i."SKU" as 'SKU',
		 SUM(v."Quantity In") as 'Quantity In',
		 SUM(v."Quantity Out") as 'Quantity Out',
     /* aggregating every entry to get a summary total for each individual item, how much is in stock. In the 'Group By' clause
     below we specify that we sort into Item type */
		 (SUM(v."Quantity In") -SUM(v."Quantity Out")) as 'On Hand',
     /* creating a column to easily see how much is on hand, current */
		 i."Purchase Price" as 'Cost',
		 i."Sales Price" as 'Retail Value',
		 (SUM(v."Quantity In") -SUM(v."Quantity Out")) * i."Purchase Price" as 'Total Cost',
		 (SUM(v."Quantity In") -SUM(v."Quantity Out")) * i."Sales Price" as 'Total Retail Value',
     /* the above two lines are then valuations of what we have on hand, bringing in price/cost data */
		 w."Warehouse Name" as 'Warehouse'
FROM  "Inventory Valuation base table" v
/* giving the various tables aliases */
LEFT JOIN "Items" i ON v."Item ID"  = i."Item ID" 
LEFT JOIN "Warehouses" w ON v."Warehouse ID"  = w."Warehouse ID" 
GROUP BY i."Item Name",
	 i."SKU",
	 i."Purchase Price",
	 i."Sales Price",
	 w."Warehouse Name"
   /* must "Group BY" any column that is not an aggregate column */
