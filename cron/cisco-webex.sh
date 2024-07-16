#!/usr/bin/env bash
(~/dynamic-allow-lists/cisco-webex.tcl || (logger -t "dynamic-allow-lists" "failed to fetch cisco webex network lists" && exit ) 2>&1 ) | ( ~/bin/pan-dynamic-static-group/refresh-static-group.exp panorama Dyn-WebEx Dyn-CiscoWebEx-Networks WebEx | logger -t "dynamic-allow-lists" 2>&1 )

