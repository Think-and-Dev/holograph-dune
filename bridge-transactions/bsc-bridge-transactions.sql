SELECT
  sum(bridge_jobs) as bridge_jobs
FROM
  (
    SELECT
      SUM(BNB.msg_count) as bridge_jobs
    FROM
      query_2465084 AS BNB
    UNION
    SELECT
      SUM(BNB.msg_count) as bridge_jobs
    FROM
      query_3431195 AS BNB
  )