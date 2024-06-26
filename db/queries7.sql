-- QUERY 7 OBJECTIVES: Top 5  recommendations in cabernet sauvignon for a VIP client. 
-- 
-- QUERY LOGIC 
--      - getting a top 20 wine list containing Cabernet (similar query than query5 query) but sorted by price (VIP client - Exclusivity )
--      - other criteria of selection then are 
--      - rating (quality)
--      - rating_count (popularity)
--      - various region (diversity)
--
-- MAIN CONCLUSIONS : 
--      - The wine have been handpicked within the table list to ensure those criteria are met (VIP treatment) 
--      - Note that same limitation apply as for query5 (reliability of grapes presence in wine because of database limiation)
-- the 5 wines chosen with the top 20 price according to that are : 
--      1. Domino de Pingus 2015 (Spain, Ribera del Duero)
--      2. Harlan Estate Harlan Estate Red 1998 (USA, Napa Valley)
--      3. Opus One 2015 (USA, Napa Valley)
--      4. Scarecrow Cabernet Sauvignon 2015 (USA, Rutherford)
--      5. Penfolds Grange 2016 (South AUstralie)




        
WITH countries_most_common_grapes AS (
    SELECT   
            most_used_grapes_per_country.grape_id AS grape_id,
            most_used_grapes_per_country.country_code as country_code
                    
    FROM    most_used_grapes_per_country
    WHERE   grape_id = 2 
    
),

ranked_vintage AS ( 
        SELECT
                
                grapes.name AS grape_name,
                vintages.name as vintage_name,
                vintages.ratings_average AS vintages_ratings,
                vintages.ratings_count as vintages_ratings_count,
                vintages.price_euros AS price,
                regions.name AS region_name,
                regions.country_code AS region_country_code
                
                   
                
        FROM    regions
                JOIN vintages ON wines.id = vintages.wine_id
                JOIN wines ON regions.id = wines.region_id
                --JOIN countries  ON regions.country_code = countries.code
                JOIN countries_most_common_grapes ON regions.country_code = countries_most_common_grapes.country_code
                JOIN grapes ON countries_most_common_grapes.grape_id = grapes.id
)
           
SELECT * FROM ranked_vintage 
ORDER BY price DESC
LIMIT 20