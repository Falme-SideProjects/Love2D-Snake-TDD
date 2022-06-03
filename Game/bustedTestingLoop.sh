#!/bin/bash

while :
do
	result=$(busted ./Tests_specs/)
	clear
	echo "$result"
	sleep 0.2
done