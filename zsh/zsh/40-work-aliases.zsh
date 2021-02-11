# ssh into a dev instance. requires atlas + the atlas micros plugin to be installed
function micros-ssh() { 
    atlas micros service ssh --service=$1 --env=$2 
}

function stacks() {
    if [ "$#" -eq 2 ]
    then
        PARAM='.environments | "'$2'" as $k'
    elif [ "$#" -eq 1 ]
    then
        PARAM='.environments | keys[] as $k'
    else
        echo "Usage: $0 <name> <end>"
        exit 1
    fi

    read -r -d '' JQ_EXPR << END
        [
            $PARAM |
            {
                env: \$k,
                url: .[\$k].url,
                stacks: {
                    stable: {
                        traffic: .[\$k].stable.traffic,
                        id: .[\$k].stable.id
                    },
                    canary: {
                        traffic: .[\$k].canary.traffic,
                        id: .[\$k].canary.id
                    },
                    previous: {
                        traffic: .[\$k].previous.traffic,
                        id: .[\$k].previous.id
                    }
                }
            }
        ]
END

    JSON_RESP=$(atlas micros service show --service $1 --output json | jq -r "$JQ_EXPR")
    echo $JSON_RESP | jq

}

function instance-type() {
    if [ "$#" -eq 2 ]
    then
        PARAM='.stacks | "'$2'" as $k'
    elif [ "$#" -eq 1 ]
    then
        PARAM='.stacks | keys[] as $k'
    else
        echo "Usage: $0 <name> <end>"
        exit 1
    fi

    read -r -d '' JQ_EXPR << END
        [
            $PARAM |
            {
                env: \$k, 
                instanceType: .[\$k][].outputs.WebServerInstance
            }
        ]
END

    JSON_RESP=$(atlas micros service show --service $1 --output json | jq -r "$JQ_EXPR")
    echo $JSON_RESP | jq

}

function sidecar-versions() {
    if [ "$#" -eq 2 ]
    then
        PARAM='.stacks."'$2'"[]'
    elif [ "$#" -eq 1 ]
    then
        PARAM='.stacks[][]'
    else
        echo "Usage: $0 <name> <end>"
        exit 1
    fi

    JSON_RESP=$(micros service:show --json $1 | jq -r "$PARAM | {env: .env, sidecars: .platformComponents}")
    echo $JSON_RESP | jq
}

func service-dns() {
    atlas slauth curl -a service-central -- "https://services.prod.atl-paas.net/api/v2/services/$1/attributes/dns-name" 2>/dev/null | jq -r '.value[].value'
}

function metric-dimensions() {
    METRIC_URL='https://api.us1.signalfx.com/v2/metrictimeseries'
    TIMEOUT=60
    METRIC_NAME=$1
    
    read -r -d '' RESP_FORMAT << END
        {
            created: (.created / 1000 | strflocaltime("%Y-%m-%d %H:%M:%S (%Z)")),
            dimensions: .dimensions
        }
END
    JSON_RESP=$(http --timeout=${TIMEOUT} GET ${METRIC_URL}/\?query\=sf_metric:${METRIC_NAME} x-sf-token:${SFX_TOKEN} | jq -r ".results[0] | ${RESP_FORMAT}")
    #JSON_RESP=$(http --timeout=${TIMEOUT} GET "${METRIC_URL}/?query\=sf_metric:${METRIC_NAME}" x-sf-token:${SFX_TOKEN} | jq -r ".results[0] | ${RESP_FORMAT}")
    echo $JSON_RESP | jq
}
