#!/bin/bash

#Color constants
RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' 


doMD5(){
  md5=$(md5sum $rFile)
  IFS=" " read -ra rHash <<< "$md5" 
}

begin(){
  for rFile in $(find $searchDir -name '*.txt' -type f -printf "%f\n")
  do  
      if [ "$rFile" == "$lFile" ]
      then doMD5

       if [ "$rHash" ==  "$lHash" ]
          then
               echo -e "${GRN}INFO${NC}: $rFile hash ${GRN}$lHash OK ${NC}"
    	       break
       else
	       echo -e "${RED}WARN${NC}: $rFile hash changed ${GRN}$lHash${NC} -> ${RED}$rHash${NC}"
       fi
    fi
  done
}

clear
echo "************************************************"
echo " 		      MD5 COMPARE              *"
echo "************************************************"
echo -en "Input the path to your hash file:  "
read hashDir
echo -en "Input the directory to search: "
read searchDir

while IFS=" " read -r -a line
  do
    lHash="${line[0]}"
    lFile="${line[1]}"
    begin
done < $hashDir




