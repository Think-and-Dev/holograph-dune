SELECT
  sum(bridge_jobs) as bridge_jobs
FROM
  (
    SELECT
      SUM(OP.msg_count) as bridge_jobs
    FROM
      query_2506131 AS OP
    UNION
    SELECT
      SUM(OP.msg_count) as bridge_jobs
    FROM
      query_3431199 AS OP
  )