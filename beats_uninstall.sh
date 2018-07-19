#!/bin/bash
systemctl stop filebeat && systemctl stop metricbeat
rpm -e filebeat && rpm -e metricbeat
systemctl daemon-reload
