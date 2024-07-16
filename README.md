# PAN Dynamic Static Group

Not to be confused with EDL (External Dynamic Lists), this routine dynamically updates Palo Alto Networks NGFW static address-groups and objects within PAN-OS configurations.

This was created becase GlobalProtect could not reference EDL for split-tunnel.

See [dynamic-allow-lists](https://github.com/nabbi/dynamic-allow-lists) for the source ip lists.

## Dry-Run

If you pass "dry-run" as the tag value, changes will be logged but not made.

## Examples

Pipe changes to system logger and catch list fetch errors before piping into PAN-OS

Microsoft M365 Optimized for split-tunnel vpn

```shell
(~/dynamic-allow-lists/microsoft-office365.tcl "Optimize" || (logger -t "dynamic-allow-lists" "failed to fetch cisco webex network lists" && exit ) 2>&1 ) | ( ~/pan-dynamic-static-group/refresh-static-group.exp Dyn-M365-Optimized Dyn-M365-Optimized-Networks Office365 | logger -t "dynamic-allow-lists" 2>&1 )
```

Cisco WebEx

```shell
(~/dynamic-allow-lists/cisco-webex.tcl || (logger -t "dynamic-allow-lists" "failed to fetch cisco webex network lists" && exit ) 2>&1 ) | ( ~/pan-dynamic-static-group/refresh-static-group.exp Dyn-WebEx Dyn-CiscoWebEx-Networks WebEx | logger -t "dynamic-allow-lists" 2>&1 )
```

Zoom

```shell
(~/dynamic-allow-lists/zoom.tcl || (logger -t "dynamic-allow-lists" "failed to fetch zoom network lists" && exit ) 2>&1 ) | ( ~/pan-dynamic-static-group/refresh-static-group.exp Dyn-Zoom Dyn-Zoom-Networks Zoom | logger -t "dynamic-allow-lists" 2>&1 )
```
