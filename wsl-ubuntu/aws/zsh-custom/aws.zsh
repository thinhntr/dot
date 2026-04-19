alias asl='aws sso login'

atx() {
  local ctx="unset\n$(aws configure list-profiles)"
  ctx=$(echo "$ctx" | fzf)
  if [[ "$ctx" == "unset" || "$ctx" == "" ]]
  then
    unset AWS_PROFILE
  else
    export AWS_PROFILE="$ctx"
  fi
}

complete -C `which aws_completer` aws
