#!/bin/bash

check_disk() {
	echo "Checking Disk Usage..."
	df -h /
}

check_disk
