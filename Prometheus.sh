#!/bin/bash

[Bash Commands]

vim /etc/prometheus/prometheus.yml #config file

sudo killall -HUP prometheus #reload prometheus with the config file

sudo killall -HUP alertmanager #reload alertmanager with the config file

echo "value 3.14" | curl --data-binary @- http://{prometheusserver}:9091/metrics/job/my_job #send to pushgateway

sudo mkdir -p /etc/prometheus/rules #directory for recording rules files




[Query]

node_cpu_seconds{mode="cpu"}

node_cpu_seconds{mode!="cpu"}

node_cpu_seconds{mode=~"cpu|mem"} # regex OR

node_cpu_seconds{mode!~"cpu|mem"} # regex NOR

node_cpu_seconds[5m]

node_cpu_seconds{mode="cpu"}[5m]

node_cpu_seconds offset 1h #1 hour ago

node_cpu_seconds[5m] offset 1h




[Query Operators]

node_cpu_seconds_total * 2

node_cpu_seconds_total % 2 #modulo

node_cpu_seconds_total ^ 2 #exponent

node_cpu_seconds_total{mode="idle"} + ignoring(mode) node_cpu_seconds_total{mode="system"} 

node_cpu_seconds_total{mode="idle"} + on(cpu) node_cpu_seconds_total{mode="system"} 

node_cpu_seconds_total{mode="idle"} > on(cpu) node_cpu_seconds_total{mode="system"} #no output means false

node_cpu_seconds_total{mode="idle"} ==bool on(cpu) node_cpu_seconds_total{mode="system"} 

node_cpu_seconds_total and node_cpu_guest_seconds_total #match on both by AND

node_cpu_seconds_total unless node_cpu_guest_seconds_total #no matching results

avg(node_cpu_seconds_total{mode="system"}) #mean

sum(node_cpu_seconds_total{mode="system"})




[Query Functions]

clamp_max(node_cpu_seconds_total, 1000) #max output value of 1000

rate(node_cpu_seconds_total[1h]) #amount of cpu usage and idle ratios




[Query Scrape Meta-Metrics]

up{job="MyJob", instance="MyInstance"} #indicates whether or not the scrape was successful

scrape_duration_seconds{job="MyJob", instance="MyInstance"} #the number of seconds the scrape took


