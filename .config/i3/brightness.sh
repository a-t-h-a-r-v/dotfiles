#!/bin/bash
brightnessctl get | awk '{print "💡 " int($1/255 * 100) "%"}'
