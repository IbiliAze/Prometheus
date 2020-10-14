#!/bin/bash

host="http://54.172.113.205:9090"
query_endpoint="/api/v1/query?query="


#curl "$host/api/v1/query" --data-urlencode "query=$1"


request() {
	read -p "Query: " query
	curl "$host$query_endpoint$query" | jq
	repeat
}

repeat() {
	request
}

repeat
