#!/bin/bash

r10k deploy environment -pv
if [ $? -ne 0 ]; then
  exit 1
else
  # Sleep to allow filesystem to sync
  sleep 10
fi
