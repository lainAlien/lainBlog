#!/bin/bash
### a tiny utility for when u edit the index.template.php and dont wanna
# manually copy everything over. it finds all the day directories and
# runs the copy command with some pretty animation if it goes a long time

for year in posts/*/; do
    for month in "$year*/"; do
        for day in "$month*/"; do
            for dir in $day; do
                cd $dir
                cp ../../../../index.template.php index.php &&\
                    gum style --foreground 199 "copied index.template.php to"
                gum style --foreground 219 $(echo $dir)"index.php"
                cd ../../../..
            done
        done
    done
done