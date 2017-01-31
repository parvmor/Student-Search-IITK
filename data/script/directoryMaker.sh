#!/bin/bash

echo "Making Necessary Directories"

cd ..
mkdir Students #top level root directory
cd Students
    
    for program in "BTech" "BS" "MTech"
    do
        echo "Making directories for ${program}"
        mkdir "${program}"
        cd ${program}
            for i in `seq 13 16`
            do
                mkdir "Y${i}"
                cd "Y${i}"
                    mkdir "Gender" "Hall" "Department" 
                    mkdir "BloodGroup" "Name" "RollNo"
                cd ..
            done
        cd ..
        echo "Directories for ${program} made"
    done

cd ..
cd script
echo "Necessary Directories Made"
