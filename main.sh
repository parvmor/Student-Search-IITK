#!/bin/bash

. ./filter.lib

if [ ! -d "./data/Students" ]; then
    echo "Database of Students does not exist locally."
    cd ./data/script
    chmod 744 scrap.sh
    ./scrap.sh
    cd -
    echo "Student Search is ready to be used now"
fi

# cool ascii art :p
toilet --metal -w 150 Student Search IITK

echo "Please choose on what basis do you want to filter your search?"

# start of asking user of filter method
PS3="Pick an Option: "
options=("Roll Number" "Name" "Blood Group" "Department" "Email-ID" "Gender" "Hall" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Roll Number")
            echo "Roll Number" ;;
        "Name")
            echo "Name" ;;
        "Blood Group")
            echo "Blood Group" ;;
        "Department")
            echo "Department" ;;
        "Email-ID")
            echo "Email-ID" ;;
        "Gender")
            echo "Gender" ;;
        "Hall")
            echo "Hall" ;;
        "Quit")
            echo "Exiting Student Search" 
            break ;;
        *)
            echo "Invalid Option" ;;
    esac
done
#end of filter
