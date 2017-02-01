#!/bin/bash

scriptPath=$(dirname $0)
PWD=`pwd`
chmod 744 "${scriptPath}/output.sh"
source "${scriptPath}/output.sh"

programs=("BTech" "BS" "MTech")

for files in "rollno.sh" "bloodGroup.sh" "name.sh" "emailid.sh"
do
    chmod 744 "${scriptPath}/filters/${files}"
    source "${scriptPath}/filters/${files}"
done

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
PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
options=("Roll Number" "Name" "Blood Group" "Department" "Email-ID" "Gender" "Hall" "Feedback" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Roll Number")
            rollno ;;
        "Name")
            name ;;
        "Blood Group")
            bloodGroup ;;
        "Department")
            echo "Department" ;;
        "Email-ID")
            emailID ;;
        "Gender")
            echo "Gender" ;;
        "Hall")
            echo "Hall" ;;
        "Feedback")
            echo "Feedback" ;;
        "Quit")
            echo "Thank You for using the search. Exiting Student Search" 
            break ;;
        *)
            echo "Invalid Option" ;;
    esac
done
#end of filter
