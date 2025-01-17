-- name: CreateFeed :one
INSERT INTO feeds (id, created_at, updated_at, name, url, user_id)
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING *;

-- name: GetFeeds :many
SELECT feeds.*, users.name as user_name
FROM feeds
JOIN users ON feeds.user_id = users.id
ORDER BY feeds.name;

-- name: GetFeedFollowsForUser :many
SELECT feed_follows.*, feeds.name as feed_name, users.name as user_name
FROM feed_follows
JOIN feeds ON feed_follows.feed_id = feeds.id
JOIN users ON feed_follows.user_id = users.id
WHERE feed_follows.user_id = $1
ORDER BY feed_name;

-- name: CreateFeedFollow :one
WITH new_follow AS (
    INSERT INTO feed_follows (id, created_at, updated_at, user_id, feed_id)
    SELECT $1, $2, $3, $4, feeds.id
    FROM feeds
    WHERE feeds.url = $5
    RETURNING *
)
SELECT 
    new_follow.*,
    feeds.name as feed_name,
    users.name as user_name
FROM new_follow
JOIN feeds ON new_follow.feed_id = feeds.id
JOIN users ON new_follow.user_id = users.id;

-- name: GetFeedByURL :one
SELECT * FROM feeds WHERE url = $1;

-- name: DeleteFeedFollow :exec
DELETE FROM feed_follows
USING feeds
WHERE feed_follows.feed_id = feeds.id
AND feed_follows.user_id = $1
AND feeds.url = $2;

-- name: MarkFeedFetched :exec
UPDATE feeds 
SET last_fetched_at = NOW(),
    updated_at = NOW()
WHERE id = $1;

-- name: GetNextFeedToFetch :one
SELECT * FROM feeds
ORDER BY last_fetched_at NULLS FIRST
LIMIT 1;