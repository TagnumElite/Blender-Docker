#!/usr/bin/env sh

data=$(curl -sSL "https://builder.blender.org/admin/api/v2/builders/16/builds?order=-number&results__eq=0&limit=1&property=got_revision&property=branch" | jq ".builds[0]")
is_master=$(echo "$data" | jq '.properties.branch[0]=="master"')

if [ "$is_master" = "false" ]; then
  idx=0
  while [ $((idx < 10 )) -ne 0 ]; do
    idx=$(( idx + 1 ))
    data=$(curl -sSL "https://builder.blender.org/admin/api/v2/builders/16/builds?order=-number&results__eq=0&limit=1&property=got_revision&property=branch&offset=$idx" | jq ".builds[0]")
    is_master=$(echo "$data" | jq '.properties.branch[0]=="master"')
    if [ "$is_master" = "true" ]; then
      break
    fi
  done
fi

echo "$data" | jq ".properties.got_revision[0].blender" | cut -c2-13
