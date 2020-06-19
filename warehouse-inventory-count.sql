SELECT
		 "Purchase Order Items"."Item ID" as "Item ID",
		 "Purchase Order Items"."Warehouse ID" as "Warehouse ID",
		 "Purchase Order Items"."Created Time" as 'Date',
		 "Purchase Order Items"."Quantity" as "Quantity In",
		 NULL as "Quantity Out",
		 NULL as "Committed Stock"
FROM  "Purchase Order Items"
JOIN "Purchase Orders" ON "Purchase Orders"."Purchase Order ID"  = "Purchase Order Items"."Purchase Order ID" 
LEFT JOIN "Purchase Receive Items" ON "Purchase Receive Items"."Purchase Order Item ID"  = "Purchase Order Items"."Item ID"  
WHERE	 "Purchase Receive Items"."Purchase Receive ID"  IS NOT NULL
UNION ALL
 SELECT
		 "Items"."Item ID" as "Item ID",
		 (		SELECT "Warehouse ID"
		FROM  "Warehouses" 
		WHERE	 "Created Time"  in
			(
			SELECT min("Created Time")
			FROM  "Warehouses" 
			)
),
		 "Items"."Created Time",
		 "Items"."Opening Stock" as "Quantity In",
		 NULL as "Quantity Out",
		 NULL as "Committed Stock"
FROM  "Items" 
UNION ALL
 SELECT
		 "Credit Note Items"."Product ID" as "Item ID",
		 "Credit Note Items"."Warehouse ID" as "Warehouse ID",
		 "Credit Note Items"."Created Time",
		 "Credit Note Items"."Quantity",
		 NULL as "Quantity Out",
		 NULL as "Committed Stock"
FROM  "Credit Note Items"
LEFT JOIN "Credit Notes" ON "Credit Note Items"."CreditNotes ID"  = "Credit Notes"."CreditNotes ID"  
WHERE	 "Credit Notes"."Credit Note Status"  not in ( 'Draft'  , 'Void'  )
UNION ALL
 SELECT
		 "Invoice Items"."Product ID" as "Item ID",
		 "Invoice Items"."Warehouse ID" as "Warehouse ID",
		 "Invoice Items"."Created Time",
		 NULL as "Quantity In",
		 "Invoice Items"."Quantity" as "Quantity Out",
		 NULL as "Committed Stock"
FROM  "Invoice Items"
LEFT JOIN "Invoices" ON "Invoice Items"."Invoice ID"  = "Invoices"."Invoice ID"  
WHERE	 "Invoices"."Invoice Status"  not in ( 'Draft'  , 'Void'  )
UNION ALL
 SELECT
		 "Vendor Credit Items"."Product ID",
		 "Vendor Credit Items"."Warehouse ID",
		 "Vendor Credit Items"."Created Time",
		 NULL as "Quantity In",
		 "Vendor Credit Items"."Quantity" as "Quantity Out",
		 NULL as "Committed Stock"
FROM  "Vendor Credit Items"
JOIN "Vendor Credits" ON "Vendor Credits"."Vendor Credit ID"  = "Vendor Credit Items"."Vendor Credit ID"  
UNION ALL
 SELECT
		 "Inventory Adjustment Items"."Product ID",
		 "Inventory Adjustment Items"."Warehouse ID",
		 "Inventory Adjustment Items"."Created Time",
		 if("Inventory Adjustment Items"."Quantity Adjusted"  > 0, "Inventory Adjustment Items"."Quantity Adjusted", 0) as "Quantity In",
		 if("Inventory Adjustment Items"."Quantity Adjusted"  < 0, -1 * "Inventory Adjustment Items"."Quantity Adjusted", 0) as "Quantity Out",
		 NULL as "Committed Stock"
FROM  "Inventory Adjustment Items" 
UNION ALL
 SELECT
		 "Sales Order Items"."Product ID",
		 "Sales Order Items"."Warehouse ID",
		 "Sales Order Items"."Created Time",
		 NULL as "Quantity In",
		 NULL as "Quantity Out",
		 "Sales Order Items"."Quantity" as "Committed Stock"
FROM  "Sales Order Items"
LEFT JOIN "Sales Order Invoice" ON "Sales Order Invoice"."Sales order ID"  = "Sales Order Items"."Sales order ID"  
WHERE	 "Sales Order Invoice"."Sales order ID"  is null
