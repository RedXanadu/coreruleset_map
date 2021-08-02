#!/bin/bash

# A little script to split the labels, some of which are very long, across
# multiple lines


#
# -- Copy file to make sure we don't overwrite the original by mistake...
NEWFILE=${1%.dot}_labelwrap.dot
cp $1 $NEWFILE

#
# -- What should the maximum line length be?
LINE_LEN=16



#
# -- Split apart so the labels start at column 0 on their on lines, like so:
#
#		rule_920220	[label="920220\nURL encoding abuse in the request URI\nPhase 2"];
# becomes:
#		rule_920220	[label="920220\n
#URL encoding abuse in the request URI
#	\nPhase 2"];
sed -i -E 's/(.+\[label="[[:digit:]]+\\n)(.+)(\\nPhase .+)/\1\n\2\n\t\3/g' $NEWFILE



#
# -- Use Perl to add in the newlines
#
# Conditional: only if line starts with non-space char (leaves alone the
# non-label bits)
perl -i -pe 's/(.{'$LINE_LEN'}) (?=\S)/$1\\n/g if /^\S/' $NEWFILE



#
# -- Putting back together

# Step 1
#		rule_920220	[label="920220\n
#URL encoding abuse in the request URI
#	\nPhase 2"];
# becomes:
#		rule_920220	[label="920220\nURL encoding abuse in the request URI
#	\nPhase 2"];
sed -i -E ':a;N;$!ba;s/(label="[[:digit:]]+\\n)\n/\1/g' $NEWFILE

# Step 2
#		rule_920220	[label="920220\nURL encoding abuse in the request URI
#	\nPhase 2"];
# becomes:
#		rule_920220	[label="920220\nURL encoding abuse in the request URI\nPhase 2"];
sed -i -E ':a;N;$!ba;s/\n\t(\\nPhase)/\1/g' $NEWFILE
