#!/bin/bash
### the script to post to the blog
# it generates a new .md file and/in the directory `posts/YYYY/MM/DD` with
# some user defined parameters, and copies a template index to the spot if
# needed. it also provides an edit menu(?)
# it makes some assumptions:
#   1 your post shortnames will be alphanumeric (not containing slashes etc.)
#   2 you're not posting more than 99 times a day
# persuant to 1, any dashes in the shortname will be turned into underscores
# in the filename, and any spaces into dashes

## some settings
# wherever on the network `posts/` lives, including the http/s 'cause im lazy
permalink="http://localhost/blog/"

if [[ -z "${EDITOR}" ]]; then
# set your $EDITOR environment variable or point this to ur favorite editor
	text_editor="/usr/bin/nano" #if gum use the gum editor (not implimented yet)
else
	text_editor="${EDITOR}"
fi

## get the date, turn it into the post directory
today=$(date +%Y/%m/%d)
post_root='posts/'$today

today=$(date +%a,\ %b\ %d,\ %Y\;\ %H:%M) #reformat for the post skeleton

postDoer() { # it should take one argument, the directory
	local root=$1
	readarray -d '' post_list < <(find $root -type f -name '*.md' -print0)
	post_list+=("new")
	if [ ${#post_list[@]} != 1 ]; then
		readarray -td '' post_list < <(printf '%s\0' "${post_list[@]}" | sort -z)
		post_url=$(printf '%s\n' "${post_list[@]}" | gum filter --fuzzy --strict\
			--header.foreground 219 --header="new post or edit an old one:")
	else
		post_url="new"
	fi
	if [ "$post_url" = "new" ]; then
		echo "Post title: (avoid characters that would break a url like & ? /)"
		post_title=$(gum input --placeholder "Post Title")
		post_file=$(echo $post_title | tr \- _)
		post_file=${post_file// /-}
		if ((${#post_list[@]} > 9)); then #get the number of posts (+1)
			post_file=${#post_list[@]}"-"$post_file
		else
			post_file="0"${#post_list[@]}"-"$post_file
		fi
		post_url=$post_file".md"
		post_url=$root"/"$post_url #build the filename with directory
		permalink=$permalink$root"?post="$post_file
		##### post skeleton #######################################################
		#   edit the `echo` strings to suit your needs
		#   remember to use >> to append to the file!!
		echo "##"$post_title > ${post_url}
		echo "###"$today >> ${post_url}
		echo "[permalink]("$permalink")" >> ${post_url}
		echo "" >> ${post_url} #finish up with a new line
		##### end of post skeleton ################################################
	fi
	$text_editor $post_url
	# confirm that the post posted and drop the link
	let confirm_width=${#permalink}+4
	gum style \
		--foreground 219 --border-foreground 199 \
		--border double --align center \
		--width $confirm_width --margin "1 2" --padding "0 0" \
		"Posted!" "$permalink"
}

### tie it all together by checking for and creating post directories
if [[ -d "${post_root}" ]]; then
	postDoer $post_root
else
	mkdir -p $post_root
	cp index.template.php $post_root/index.php
	postDoer $post_root
fi
