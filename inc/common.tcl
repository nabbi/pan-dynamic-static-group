# shothand our logger
proc log {level msg} {
    puts "#log: $level $msg"
    exec /usr/bin/logger -p user.${level} "[info script] ${msg}"
}

## exit if child proccess fails, otherwise return result
proc myexec {args} {
    # set these incase we need to pass to logoff
    set h [lindex $args 1]
    set s [lindex $args 2]

    set status 0
    if {[catch {exec {*}$args} results options]} {
        set details [dict get $options -errorcode]
        if {[lindex $details 0] eq "CHILDSTATUS"} {
        set status [lindex $details 2]
        } else {
        # Some other error; regenerate it to let caller handle
        # return -options $options -level 0 $results
        set status 70
        }
    }
    if { $status } {
        # this isn't quite right but presents the resulting error and retruns error
        set msg "exit error $status $results"
        log "error" $msg
        return -code error --errorinfo $results --errorcode $status
    }
    return $results
}
# use an ip calculator to normalize the input
proc netmask {cidr} {

    set sipcalc [myexec sipcalc $cidr]

    foreach line [split $sipcalc "\n"] {

        switch -glob -- $line {
            "Network address*" {
                # ipv4
                set ipv4 [lindex $line 3]
                continue
            }
            "Network mask (bits)*" {
                # ipv4
                set ipv4mask [lindex $line 4]
            }
            "Compressed address*" {
                # ipv6
                set ipv6 [lindex $line 3]
            }
            "Prefix length*" {
                # ipv6
                set ipv6prefix [lindex $line 3]
            }

            default {}
        }
    }

    if { [info exists ipv4] && [info exists ipv4mask] } {
        # retrun host formatted entry
        if { [string match $ipv4mask "32"] } {
            return $ipv4
        } else {
            return "$ipv4/$ipv4mask"
        }

    } elseif { [info exists ipv6] && [info exists ipv6prefix] } {
        # retrun host formatted entry
        if { [string match $ipv6prefix "128"] } {
            return $ipv6
        } else {
            return "$ipv6/$ipv6prefix"
        }
    } else {
        # this will trigger the caller skip this entry if we got bad info
        return -code continue
    }

}
