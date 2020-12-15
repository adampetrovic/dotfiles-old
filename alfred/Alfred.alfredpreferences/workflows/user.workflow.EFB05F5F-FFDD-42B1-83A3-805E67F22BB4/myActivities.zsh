#!/bin/zsh -f

set -ex

operationName="${1:?}"
operationActivityElement="${2:?}"

# Use chosen jq if specified, otherwise search path, otherwise use brew default location
: JQ="${JQ:=${$(whence jq):-/usr/local/bin/jq}}"
"${JQ}" . /dev/null || {
cat<<'END_HELP'
{ "items": [ {
  "title" : "jq not found - \"brew install jq\" (Cmd+C copies this)",
  "text" : { "copy": "brew install jq" },
  "valid" : false 
} ] }
END_HELP
  false
}

graphqlQuery="$(tr -s '\n' ' '<<END_GQL
query ${operationName}(\$filter: ActivityFilter!, \$first: Int) {
    myActivities {
        ${operationActivityElement}(filter: \$filter, first: \$first) {
            nodes {
                id object {
                    url content {
                        title
                        space { name }
                    }
                }
            }
        }
    }
}
END_GQL
)"
{ curl --disable --silent --netrc --header 'Content-Type:application/json' --data-binary @- \
    "https://hello.atlassian.net/cgraphql?q=${operationName}" \
    | "${JQ}" --from-file =(cat << END_JQ
.data.myActivities.${operationActivityElement}.nodes | { "items" : [ .[] | {
    "uid" : .id,
    "title" : .object.content.title,
    "subtitle" : "in space '\\(.object.content.space.name)'",
    "arg" : .object.url
} ] }
END_JQ
) } <<END_POST
{
  "operationName": "${operationName}",
  "variables": {
    "filter": {
      "products": [ "CONFLUENCE" ],
      "objectTypes": [ "PAGE", "BLOGPOST" ],
      "cloudIDs": [ "a436116f-02ce-4520-8fbb-7301462a1674" ],
      "earliestStart": "$(date -u -v-1m -v0H -v0M -v0S -v-1S '+%Y-%m-%dT%H:%M:%S.999Z')"
    },
    "first": 100
  },
  "query": "${graphqlQuery}"
}
END_POST
