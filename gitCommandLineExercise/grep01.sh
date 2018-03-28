#!/bin/bash
a = $(git branch | sed 's/*/ /g')

for i in $(a)

do 
git grep -n master $i
done
