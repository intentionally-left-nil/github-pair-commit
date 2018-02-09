# These functions set and unset environment variables
# As such, they need to be compatible with bash and zsh
# so they can run in the current context, and not as a child process

function pair_with()
{
  if [ "$#" -eq 0 ]; then
    work_solo
  else
    local output=`pair_with_impl.sh $1`
    if [ "$?" -eq 0 ]; then
      export GIT_PAIR_USERNAME=`echo "${output}" | head -1 | tail -1`
      export GIT_PAIR_NAME=`echo "${output}" | head -2 | tail -1`
      export GIT_PAIR_EMAIL=`echo "${output}" | head -3 | tail -1`
      echo "Now pairing with $GIT_PAIR_NAME <$GIT_PAIR_EMAIL>"
    fi
  fi
}

function work_solo()
{
  unset GIT_PAIR_USERNAME
  unset GIT_PAIR_NAME
  unset GIT_PAIR_EMAIL
  echo "Now working solo"
}
