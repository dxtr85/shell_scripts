echo "alias ser=\"grep -rnw ./ -e\"" >> ~/.bashrc
echo "alias serpy=\"grep --include=\*.py -rnw ./ -e\"" >> ~/.bashrc
echo "alias gbl=\"git branch| awk '{printf(\\\"%3d: %s\n\\\", NR, \\\$0)}'\"" >> ~/.bashrc
echo "gbn() { if [[ \$# -ne 1 ]] ; then echo \"You need to pass a number argument!\" ; else eval \"git branch | awk 'NR == \$1'\" ; fi }"  >> ~/.bashrc

source ~/.bashrc
