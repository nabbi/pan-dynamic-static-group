#!/usr/bin/env bash
(~/dynamic-lists/zoom.tcl || (logger -t "dynamic-lists" "failed to fetch zoom network lists" && exit ) 2>&1 ) | ( ~/bin/pan-dynamic-static-group/refresh-static-group.exp panorama Dyn-Zoom Dyn-Zoom-Networks Zoom | logger -t "dynamic-lists" 2>&1 )

