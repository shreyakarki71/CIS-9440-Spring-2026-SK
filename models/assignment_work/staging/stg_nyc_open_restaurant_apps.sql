-- Clean and standardize NYC Open Restaurant application data
-- One row per application record

WITH source AS (
    SELECT *
    FROM {{ source('raw', 'source_nyc_open_restaurant_apps') }}
),

cleaned AS (
    SELECT
        -- Keep all other columns except the ones being transformed below
        * EXCEPT (
            objectid,
            globalid,
            zip,
            latitude,
            longitude,
            approved_for_roadway_seating,
            approved_for_sidewalk_seating,
            bulding_number
        ),

        -- Identifiers
        CAST(objectid AS STRING) AS application_id,
        CAST(globalid AS STRING) AS global_id,

        -- Clean ZIP code
        CASE
            WHEN zip IS NULL OR TRIM(CAST(zip AS STRING)) = '' THEN NULL
            WHEN LENGTH(TRIM(CAST(zip AS STRING))) = 5 THEN TRIM(CAST(zip AS STRING))
            WHEN LENGTH(TRIM(CAST(zip AS STRING))) = 4 THEN CONCAT('0', TRIM(CAST(zip AS STRING)))
            ELSE NULL
        END AS zip,

        -- Coordinates
        CAST(latitude AS DECIMAL) AS latitude,
        CAST(longitude AS DECIMAL) AS longitude,

        -- Fix typo in raw column name
        CAST(bulding_number AS STRING) AS building_number,

        -- Standardize yes/no values
        LOWER(TRIM(CAST(approved_for_roadway_seating AS STRING))) AS approved_for_roadway_seating,
        LOWER(TRIM(CAST(approved_for_sidewalk_seating AS STRING))) AS approved_for_sidewalk_seating,

        -- Metadata
        CURRENT_TIMESTAMP() AS _stg_loaded_at

    FROM source

    -- Basic filters
    WHERE objectid IS NOT NULL
      AND time_of_submission IS NOT NULL
      AND borough IS NOT NULL

    -- Deduplicate: keep the most recent row for each objectid
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY objectid
        ORDER BY time_of_submission DESC
    ) = 1
)

SELECT * FROM cleaned