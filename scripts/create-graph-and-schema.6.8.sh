#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# can specify ip optionally as first arg. If not specified will return blank
ip_addr=${1:- }

echo "running console on ip $ip_addr"
# create graph
dse gremlin-console $ip_addr -e $SCRIPT_DIR/create-graph.groovy && \

# create schema
# First v label, then e label
# for now, just always use custom partition key for edges. That way can either specify it's on the supernode or specify that it's not, easier for testing
dse gremlin-console $ip_addr \
    -e $SCRIPT_DIR/setup-remote.groovy \
    -e $SCRIPT_DIR/create-schema.6.8.vertexLabel.groovy \
    -e $SCRIPT_DIR/create-schema.6.8.edge.with-custom-partitions.groovy