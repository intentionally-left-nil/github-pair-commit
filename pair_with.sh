#! /bin/bash

function pair_with()
{
  local profile=`curl -H "Accept: application/json" -s GET "https://api.github.com/users/$1"`
  local name=`echo $profile | jq -r ".name"`
  local email=`echo $profile | jq -r ".email"`
  if [ "$email" == "null" ]; then
    local events=`curl -H "Accept: application/json" -s GET "https://api.github.com/users/$1/events/public"`
    email=$(echo $events | jq -r ".[].payload?.commits?[]?.author? | select(.name == \"$name\") | .email" | head -n 1)
    if [ -z "$EMAIL" ]; then
      email="$1@users.noreply.github.com"
    fi
  fi
  export GIT_PAIR_USERNAME=$1
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
