#!/bin/bash

echo "Making Necessary Directories"
echo

cd ..
mkdir Students #top level root directory
cd Students
    
    for i in `seq 11 16`
    do
        echo "Making directories for Y${i}"
        mkdir "Y${i}"
        cd "Y${i}"
            for programs in "BTech" "MTech" "BS"
            do
                mkdir "${programs}"
                cd "${programs}"
                    touch "Gender" "Hall" "Department" 
                    touch "BloodGroup" "Name" "RollNo"
                    touch "EmailID"
                cd ..
            done
        cd ..
        echo "Directories for Y${i} made"
        echo 
    done

cd ..
cd script
echo "Necessary Directories Made"
echo
