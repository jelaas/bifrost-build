#!/bin/bash

#
# Needs 'graphviz' (for 'neato' graphdrawing)
#

F=/tmp/n.$$

cat <<EOF > $F
graph G {
/*    overlap=scale; */
    overlap=false;
      splines=true;
      sep=.2
      edge [dir=forward,len=1.0];
      node [shape=box];
EOF

x=0
for d in all/*; do
    p=$(basename $d)
    [ -f $d/Build.sh ] || continue
    if ! grep -qs ^pkg_install $d/Build.sh; then
	echo "{node [pos=\"0.5,0.5\",fontsize=20,style=filled,color=skyblue] \"$p\"};" >> $F
	x=$[x+1]
    fi
done

for d in all/*; do
    p=$(basename $d)
    [ -f $d/Build.sh ] || continue
    if grep -qs ^pkg_install $d/Build.sh; then
	for dep in $(grep ^pkg_install $d/Build.sh|cut -d' ' -f2); do
	    echo "\"$p\" -- \"$dep\"" >> $F	    
	done
    fi
done

echo "}" >> $F

neato -Tps $F -Gepsilon=.00000001 -o dep.ps

rm -f $F
echo "Generated dep.ps"
