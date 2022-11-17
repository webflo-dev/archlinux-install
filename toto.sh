#!/usr/bin/env bash

# packages=( $(tail -n +2 packages/extra.csv | cut -d ';' -f1) )
# toto=$(gum choose --no-limit --height 10 --cursor "> " --cursor-prefix "[•] " --selected-prefix "[x] " --unselected-prefix "[ ] "  "${packages[@]}")

function filter(){
  local -n source=$1
  for foo in "${source[@]}"; do
      case "$foo" in
          $2) printf '%s\n' "$foo" ;;
      esac
  done
}

array=(saf sri trip tata strokes)                      
input=*tr*
# filter array $input
declare -a toto=( $(filter array $input))
# for found in ${toto[@]}; do
#   echo "found >> $found"
# done



echo




# declare -A PERSONS
# declare -A PERSON

# PERSON["FNAME"]='John'
# PERSON["LNAME"]='Andrew'
# i=1
# for key in "${!PERSON[@]}"; do
#   PERSONS[$i,$key]=${PERSON[$key]}
# done

# PERSON["FNAME"]='Elen'
# PERSON["LNAME"]='Murray'
# ((i++))
# for key in "${!PERSON[@]}"; do
#   PERSONS[$i,$key]=${PERSON[$key]}
# done

# declare -p PERSONS
# echo ">> ${!PERSONS[@]}"


s='Joe,1996-10-25,64,78'
echo "$s" | awk -F, '{split($2, d, "-"); print $1 " was born in " d[1]}'

toto="grex httm fd"
tail -n +2 /home/florent/dev/webflo/archlinux-install/packages.csv | awk -v "packages=$toto" -F',' 'BEGIN {
  split(packages, tmp, " ");
  for (i in tmp) selected_packages[tmp[i]] = "";
}
  ($3 in selected_packages) { print $0 }
'

# BEGIN {

#     split("value1 value2", valuesAsValues)
#     # valuesAsValues = {0: "value1", 1: "value2"}

#     for (i in valuesAsValues) valuesAsKeys[valuesAsValues[i]] = ""
#     # valuesAsKeys = {"value1": "", "value2": ""}
# }

# # Now you can use `in`
# ($1 in valuesAsKeys) {print}


infinityAndBeyond() {
  while true; do
    echo $(date)
    sleep 1
  done
}
infinityAndBeyond &
gum pager < $(infinityAndBeyond)