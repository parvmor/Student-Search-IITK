#!/bin/bash

echo "Checking if Students directory exists"
if [ ! -d "Students"  ]; then
    ./directoryMaker.sh
else
    echo "Directory Student Already Exists"
fi

echo "Starting to scrap data now..."

extract() {
    data=$(curl -s http://oa.cc.iitk.ac.in/Oa/Jsp/OAServices/IITk_SrchRes.jsp?sbm=Y -d typ="stud" -d numtxt=$1) # store data in a variable for multiple use
    cd Students
    echo $data | 

}
export -f extract # export extract as xargs calls it from a bash

# for btech y16
seq 160001 160832 | xargs -P0 -I {} bash -c 'extract {}' 
