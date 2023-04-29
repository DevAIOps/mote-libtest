#! /bin/sh
#
# collectd -- testwrapper.sh
#
# A wrapper script for running tests. If valgrind is available, memory
# checking will be enabled for all tests.

set -e

MEMCHECK=""
VALGRIND=valgrind

if test -n "$VALGRIND"; then
	MEMCHECK="$VALGRIND --quiet --tool=memcheck --error-exitcode=1"
	#MEMCHECK="$MEMCHECK --trace-children=yes"
	MEMCHECK="$MEMCHECK --leak-check=full"
	MEMCHECK="$MEMCHECK --gen-suppressions=all"
	MEMCHECK="$MEMCHECK --show-reachable=yes"

	for f in "valgrind.$( uname -s ).suppress" "valgrind.suppress"; do
		filename="$( dirname "$0" )/$f"
		if test -e "$filename"; then
			# Valgrind supports up to 100 suppression files.
			MEMCHECK="$MEMCHECK --suppressions=$filename"
		fi
	done
fi

exec $MEMCHECK "$@"

# vim: set tw=78 sw=4 ts=4 noexpandtab :

