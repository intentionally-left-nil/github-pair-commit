#! /bin/bash

function pair_with()
{
  local username=$1
  local profile=`curl -H "Accept: application/json" -s GET "https://api.github.com/users/$username"`
  local name=`echo $profile | jq -r ".name"`
  local email=`echo $profile | jq -r ".email"`
  if [ "$name" == "null" ]; then
    local profilemessage=`echo $profile | jq -r ".message"`
    if [ "$profilemessage" == "Not Found" ]; then
      echo "$username is not a valid github username"
      return 1
    fi

    if [[ "$profilemessage" = *"API rate limit exceeded"* ]]; then
      echo "The Github API is currently rate limited"
      echo "Please manually export GIT_PAIR_NAME and GIT_PAIR_EMAIL"
      return 2
    fi
  fi

  if [ "$email" == "null" ]; then
    local events=`curl -H "Accept: application/json" -s GET "https://api.github.com/users/$username/events/public"`
    email=$(echo $events | jq -r ".[].payload?.commits?[]?.author? | select(.name == \"$name\") | .email" | head -n 1)
    if [ -z "$EMAIL" ]; then
      email="$1@users.noreply.github.com"
    fi
  fi
  export GIT_PAIR_USERNAME=$username
  export GIT_PAIR_NAME=$name
  export GIT_PAIR_EMAIL=$email
  echo "Now pairing with $GIT_PAIR_NAME <$GIT_PAIR_EMAIL>"
}

function work_solo()
{
  unset GIT_PAIR_USERNAME
  unset GIT_PAIR_NAME
  unset GIT_PAIR_EMAIL
  echo "Now working solo"
}
