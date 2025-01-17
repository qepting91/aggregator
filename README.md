# Gator RSS Feed Aggregator

A powerful command-line RSS feed aggregator built in Go that helps you follow and manage your favorite RSS feeds.

## Prerequisites

- Go 1.20 or higher
- PostgreSQL 12 or higher

## Installation

Install the Gator CLI directly using Go:

```bash
go install github.com/qepting91/aggregator@latest
```

## Configuration

1. Create a config file at `~/.config/gator/config.json`:
```json
{
    "database_url": "postgresql://username:password@localhost:5432/gator?sslmode=disable"
}
```

## Usage

Gator provides a rich set of commands for managing feeds and content:

### User Management
- `gator register <username>` - Create a new user
- `gator login <username>` - Login as a user
- `gator users` - List all users

### Feed Management
- `gator addfeed <name> <url>` - Add and follow a new feed
- `gator feeds` - List all feeds
- `gator follow <url>` - Follow an existing feed
- `gator following` - List feeds you follow
- `gator unfollow <url>` - Unfollow a feed

### Content
- `gator browse [limit]` - Browse posts from followed feeds
- `gator agg <interval>` - Start the feed aggregator (e.g., "agg 1m" for 1-minute intervals)

## Technical Details
- Uses PostgreSQL for data storage
- Implements middleware pattern for authentication
- Handles RSS feed parsing and storage
- Manages concurrent feed aggregation
- Provides user-specific feed management

## Key Features
- Real-time feed aggregation
- Multi-user support
- Duplicate post detection
- Configurable post browsing
- Feed following system

## Development
To run the project locally:
```bash
go run . register myuser
go run . login myuser
go run . addfeed "My Feed" "https://example.com/feed.xml"
```

## Cybersecurity RSS Feeds
Thank you to [thehappydinoa](https://github.com/thehappydinoa/awesome-threat-intel-rss) for providing a curated list of RSS feeds for cybersecurity news and updates. Pulled from a fork of the great work over at [muchdogesec](https://github.com/muchdogesec/awesome_threat_intel_blogs).