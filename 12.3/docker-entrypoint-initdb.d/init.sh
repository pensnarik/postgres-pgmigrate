#!/bin/bash

cd /db && pgmigrate -t latest migrate
