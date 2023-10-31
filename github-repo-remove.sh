#!/bin/bash

# GitHub username and personal access token for authentication
read -p "github-username: " USERNAME
read -p "github-access token: " ACCESS_TOKEN

# Name of the repository you want to check and potentially delete
read -p "YourRepositoryName: " REPO_NAME

# Calculate the date 6 months ago in ISO 8601 format
SIX_MONTHS_AGO=$(date -I -d '6 months ago')
# FIVE_MINUTES_AGO=$(date -I -d '1 minutes ago')


# Get the last commit date of the repository
LAST_COMMIT_DATE=$(curl -s -u $USERNAME:$ACCESS_TOKEN -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/$USERNAME/$REPO_NAME/commits?per_page=1" | jq -r '.[0].commit.committer.date')

# Compare the last commit date with the cutoff date
if [[ "$LAST_COMMIT_DATE" < "$SIX_MONTHS_AGO" ]]; then
  echo "The repository $USERNAME/$REPO_NAME has had no commits in the last 6 months."
  read -p "Do you want to delete it? (yes/no): " DELETE_CONFIRM
  if [ "$DELETE_CONFIRM" = "yes" ]; then
    echo "Deleting the repository..."
    curl -X DELETE -u $USERNAME:$ACCESS_TOKEN "https://api.github.com/repos/$USERNAME/$REPO_NAME"
    echo "Repository deleted for $USERNAME/$REPO_NAME."
  else
    echo "No action taken. Repository not deleted."
  fi
else
  echo "The repository $USERNAME/$REPO_NAME has had commits in the last 6 months. No action taken."
fi
