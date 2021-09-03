#checking to see if all barcodes are populated with valid values
SELECT Receipts_id
FROM database.Receipts
WHERE  barcode IS NULL

#checking for duplicate User_id values
SELECT
    User_id,
    SUM(1) AS count
FROM database.Users
GROUP BY 1
HAVING count > 1

#looking for brand_id values that are empty and are duplicates
SELECT Brand_id, “missing_value” AS reason
FROM database.brand
WHERE barcode IS NULL

UNION ALL

SELECT Brand_id, “duplicate_id” AS reason
FROM (
    SELECT Brand_id, SUM(1) AS count
    FROM database.brand
    GROUP BY 1
)
WHERE count > 1

#Our data has missing fields in some of our key attributes such as barcode and customer_Id
#Additionally, we have duplicate data in fields connecting our datasets together. 
#Our current data set are not standardized and in fields such as barcode and topbrand we have not accepted values. 
#There are inconsistent formats between the datasets that would create issues when we try to merge our data in the new system. 