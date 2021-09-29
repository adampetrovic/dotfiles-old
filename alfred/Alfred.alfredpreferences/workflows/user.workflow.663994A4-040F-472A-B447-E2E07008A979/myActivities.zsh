#!/bin/zsh -f

set -ex

operationName="${1:?}"
operationActivityElement="${2:?}"

: HELLO="${HELLO:=hello.atlassian.net}"

# Use chosen jq if specified, otherwise search path, otherwise use brew default location
: JQ="${JQ:=${$(whence jq):-/usr/local/bin/jq}}"

# Check jq works, otherwise offer some help via the alfred UI
# At this stage, we can't use jq to format the error message, so
# be careful with JSON escaping below.
"${JQ}" . /dev/null || {
  cat<<'END_HELP'
{ "items": [ {
  "title" : "jq not found - \"brew install jq\"",
  "subtitle" : "You can use Cmd+C to copy that install command",
  "text" : { "copy": "brew install jq" },
  "valid" : false 
} ] }
END_HELP
  exit 1
}

# Now that we have working jq, we can format arbitrary errors
error() {
  title="${1:?}"
  subtitle="${2:?}"
  # default copy text to title if not given to simplify bug reporting
  copy="${3-${title}}"
  "${JQ}" --arg title "${title}" --arg subtitle "${subtitle}" --arg copy "${copy}" --null-input \
    '{ "items": [ { "title": $title, "subtitle": $subtitle, "text": { "copy": $copy }, "valid": false } ] }'
  exit 1
}

graphqlQuery="$(tr -s '\n' ' '<<END_GQL
query ${operationName}(\$filter: ActivitiesFilter!, \$first: Int) {
    activities {
        myActivities {
            ${operationActivityElement}(filters: [ \$filter ], first: \$first) {
                nodes {
                    id
                    object {
                        content {
                            id
                            title
                            space { name }
                        }
                    }
                }
            }
        }
    }
}
END_GQL
)"

postBody="$(cat<<END_POST
{
  "operationName": "${operationName}",
  "variables": {
    "filter": {
      "type": "AND",
      "arguments": {
          "products": [ "CONFLUENCE" ],
          "objectTypes": [ "PAGE", "BLOGPOST" ],
          "cloudIds": [ "a436116f-02ce-4520-8fbb-7301462a1674" ],
          "earliestStart": "$(date -u -v-1m -v0H -v0M -v0S -v-1S '+%Y-%m-%dT%H:%M:%S.999Z')"
      }
    },
    "first": 100
  },
  "query": "${graphqlQuery}"
}
END_POST
)"

jqParser="$(cat<<END_JQ
.data.activities.myActivities.${operationActivityElement}.nodes | { items : [ .[] | {
    uid : .id,
    title : .object.content.title,
    subtitle : "in space '\\(.object.content.space.name)'",
    arg : "https://${HELLO}/wiki/pages/viewpage.action?pageId=\\(.object.content.id)"
} ] }
END_JQ
)"

# a zsh iife to get a zsh managed temporary file
() {
  # temporary file from the =() expansion to the iife
  curlOut="${1:?}"
  # Use --disable to ignore the users .curlrc
  # Don't pass --fail, as we check the code afterwards, whereas --fail will suppress
  # the output of the response body to the file, which makes diagnosing errors harder.
  {
    httpCode=$( curl --disable --silent --show-error --write-out '%{http_code}' --netrc --location \
        --user-agent 'alfred-hello-workflow (go/helloalfred, or ask @g8sy on Slack)' \
        --header 'Content-Type:application/json' \
        --data-binary @- --output "${curlOut}" \
        "https://${HELLO}/cgraphql?q=${operationName}" ) \
      || \
        error "curl failed ($?) to reach ${HELLO}" "Use Cmd+C to copy this message, then slack it to @g8sy"
    case "${httpCode}" in
      2*|3*) : "accepting response code ${httpCode}" ;;
      *) error \
        "${HELLO} said ${httpCode}" \
        "Double check you have put an API token in ${HOME}/.netrc (Cmd+C to copy response)" \
        "$(cat "${curlOut}")" ;;
    esac
  }<<<"${postBody}"
  "${JQ}" "${jqParser}" "${curlOut}" || \
    error \
      "Couldn't parse response from ${HELLO}" \
      "Double check your netrc login includes @atlassian.com (Cmd+C to copy response)" \
      "$(cat "${curlOut}")"
} =(true)
