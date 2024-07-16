#!/usr/bin/env bash
2 30 * * * (~/dynamic-allow-lists/microsoft-office365.tcl "Allow" || (logger -t "dynamic-allow-lists" "failed to fetch ms o365 allow network lists" && exit ) 2>&1 ) | grep -v ":" | ( ~/bin/pan-dynamic-static-group/refresh-static-group.exp Dyn-M365-Allow Dyn-M365-Allow-Networks Office365 | logger -t "dynamic-allow-lists" 2>&1 )

