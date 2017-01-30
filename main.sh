#!/bin/bash

# cool ascii art :p
toilet --metal -w 150 Student Search IITK

echo "Please choose on what basis do you want to filter your search?"

# start of asking user of filter method
PS3="Pick an Option: "
options=("Quit")
select opt in "${options[@]}"
do
    case "$opt" in
        "")
            ;;
        "")
            ;;
        "")
            ;;
        "Quit")
            break;;
        *)
            echo "invalid option" ;;
    esac
done
#end of filter
