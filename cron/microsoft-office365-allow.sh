#!/usr/bin/env bash
(~/dynamic-lists/microsoft-office365.tcl "Allow" || (logger -t "dynamic-lists" "failed to fetch ms o365 allow network lists" && exit ) 2>&1 ) | grep -v ":" | ( ~/bin/pan-dynamic-static-group/refresh-static-group.exp panorama Dyn-M365-Allow Dyn-M365-Allow-Networks Office365 | logger -t "dynamic-lists" 2>&1 )

