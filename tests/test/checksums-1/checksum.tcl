set autoconf "../../../Mk/macports.autoconf.mk"

# Sets $bindir variable from macports.autoconf.mk
# autogenerated file.
proc load_variables {} {
    global autoconf
    global bindir

    if { [file exists $autoconf] == 0 } {
        puts "$autoconf does not exist."
        exit 1
    }

    set line [get_line $autoconf "prefix"]
    set prefix [lrange [split $line " "] 1 1]

    set line [get_line $autoconf "bindir"]
    set bin [lrange [split $line "/"] 1 1]

    set bindir $prefix/$bin/
}

# Executes port clean.
proc clean {} {
    global bindir

    set args "clean"
    set cmd "port"

    set result [eval exec $bindir$cmd $args]]
}

# Runs the portfile.
proc run {} {
    global bindir

    set args "-d test"
    set output "output"
    set cmd "port"

    set result [catch {eval exec $bindir$cmd $args >&output} ]
    return $result
}

# Returns the line containint a given string
# from a given file, or -1 if nothing is found.
proc get_line {filename lookup} {
    set fp [open $filename r]

    while {[gets $fp line] != -1} {
        set line [string tolower $line]

        if {[string first $lookup $line 0] != -1} {
            close $fp
            return $line
        }
    }
    return -1
}


proc get_md5 {filename} {
    set md5 "debug: calculated (md5)"

    set line [get_line $filename $md5]
    set result [lrange [split $line " "] 4 4]

    return $result
}


proc get_sha {filename} {
    set sha "debug: calculated (sha1)"

    set line [get_line $filename $sha]
    set result [lrange [split $line " "] 4 4]

    return $result
}


proc get_rmd {filename} {
    set sha "debug: calculated (rmd160)"

    set line [get_line $filename $sha]
    set result [lrange [split $line " "] 4 4]

    return $result
}