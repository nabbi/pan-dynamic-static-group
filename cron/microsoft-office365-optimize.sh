#!/usr/bin/env bash
(~/dynamic-allow-lists/microsoft-office365.tcl "Optimize" || (logger -t "dynamic-allow-lists" "failed to fetch ms o365 optimize network lists" && exit ) 2>&1 ) | grep -v ":" | ( ~/bin/pan-dynamic-static-group/refresh-static-group.exp Dyn-M365-Optimized Dyn-M365-Optimized-Networks Office365 | logger -t "dynamic-allow-lists" 2>&1 )

