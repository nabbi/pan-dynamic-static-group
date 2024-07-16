#!/usr/bin/env bash
(~/dynamic-allow-lists/zoom.tcl || (logger -t "dynamic-allow-lists" "failed to fetch zoom network lists" && exit ) 2>&1 ) | ( ~/bin/pan-dynamic-static-group/refresh-static-group.exp panorama Dyn-Zoom Dyn-Zoom-Networks Zoom | logger -t "dynamic-allow-lists" 2>&1 )

