SELECT SUM(total_transactions) AS total_transactions FROM (
WITH optimism_holograph_protocol_transactions AS (
  SELECT
    tx_hash AS tx,
    COUNT(index) AS id
  FROM optimism.logs
  WHERE
    block_time >= TRY_CAST('2023-01-01 00:00:00' AS TIMESTAMP)
    AND block_time < TRY_CAST('2024-01-01 00:00:00' AS TIMESTAMP)
    AND (
      contract_address IN (
        SELECT 
          contract_address 
        FROM query_2506102
      ) -- Optimism - deployed holographable contracts
      OR contract_address IN (
        SELECT 
          contract_address 
        FROM query_2357917
      ) -- Holograph Protocol contract addresses
    )
  GROUP BY
    tx_hash
), optimism_holograph_protocol_transactionsV2 AS (
  SELECT
    tx_hash AS tx,
    COUNT(index) AS id
  FROM optimism.logs
  WHERE
    block_time >= TRY_CAST('2024-01-01 00:00:00' AS TIMESTAMP)
    AND block_time < TRY_CAST('2026-01-01 00:00:00' AS TIMESTAMP)
    AND (
      contract_address IN (
        SELECT 
          contract_address 
        FROM query_3410749
      ) -- Optimism - deployed holographable contracts V2
      OR contract_address IN (
        SELECT 
          contract_address 
        FROM query_3410710
      ) -- Holograph Protocol contract addresses V2
    )
  GROUP BY
    tx_hash
)
SELECT
  COUNT(tx) AS total_transactions
FROM optimism_holograph_protocol_transactions
UNION ALL
SELECT
  COUNT(tx) AS total_transactions
FROM optimism_holograph_protocol_transactionsV2)