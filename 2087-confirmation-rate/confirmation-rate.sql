# Write your MySQL query statement below
WITH requests AS(
    SELECT
        s.user_id
        , COUNT(c.action) requests
    FROM Signups s
    LEFT JOIN Confirmations c
        ON s.user_id = c.user_id
    GROUP BY 1
)

, confirmations AS(
    SELECT
        s.user_id
        , COUNT(c.action) confirmations
    FROM Signups s
    LEFT JOIN Confirmations c
        ON s.user_id = c.user_id
    WHERE action = "confirmed"
    GROUP BY 1
)

SELECT
    r.user_id
    , COALESCE(ROUND(confirmations/requests,2),0) AS confirmation_rate
FROM requests r
LEFT JOIN confirmations c
    ON r.user_id = c.user_id
GROUP BY 1