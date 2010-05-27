#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :


TEMPLATES_DIR="/home/nikolavp/Documents/Templates/"
TEMPLATE=""
DESTINATION="." #Assume that we need to copy here
NAME="" 	#The name of the new project
VERBOSE=0 #Debug is off by default
usage(){
    cat << EOF
    usage : $0 <options>
    OPTIONS:
    -h      show this message
    -t      template name
    -l      list of template names 
    -d      output directory for the template
    -v      verbose
EOF
}
list_templates(){
    ls -1 $TEMPLATES_DIR
}
if [[ $# == 0 ]]; then
    usage
    exit 1
fi

while getopts "hlt:d:n:v" OPTION
do
    case $OPTION in
        h)
        usage
        exit 1
        ;;
        l)
        list_templates
        exit 1
        ;;
        t)
	TEMPLATE=$OPTARG
        ;;
        d)
        DESTINATION=$OPTARG
        ;;
        v)
        VERBOSE=1
        ;;
	n)
	NAME=$OPTARG
	;;
        ?)
        usage
        ;;
    esac
done
#Check if the template exists
if [[ ! -d $TEMPLATES_DIR$TEMPLATE ]];then
    echo "No such a template"
    exit 1
fi
cp -r $TEMPLATES_DIR$TEMPLATE $DESTINATION/$NAME