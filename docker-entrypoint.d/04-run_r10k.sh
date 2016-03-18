#!/bin/bash

r10k deploy environment -pv
# Sleep to allow filesystem to sync
sleep 10
