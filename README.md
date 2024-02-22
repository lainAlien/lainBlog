# lainBlog
a super tiny and basic blogging software for people that like to go on the ssh and use 2 computers at once

## thought process
I was high at work and thought "I bet I could make a blog" and then thought the whole thing out lol

## installing
*assuming u already have a web server running php*

install [gum](https://github.com/charmbracelet/gum) however u please

clone this repo (and its submodule [parsedown](https://github.com/erusev/parsedown) to wherever on your domain u want ur blog to be, for example in a blog subdirectory:
```
git clone --recursive https://github.com/lainAlien/lainBlog.git blog
```
enter that directory and edit the following:
* in `post.sh` edit the permalink variable (line 14) to point to ur blog subdirectory on ur domain
* also in `post.sh` u can select a text editor if ur $EDITOR isnt set
* in `navbar.php` edit $blog_root to point to the same as above

everything should be pretty easy to mash together with the rest of your site from there

## usage
to make a new post, just run `post.sh` where it is. after some prompts the script will create directory called posts with folder tree based on the date, copy an index template over to it, and open a new [github-flavored markdown](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) file for editing. if you're making multiple posts in the same day or want to edit an existing post from today, it'll present u with a menu to edit one of those instead.

if you have a few posts already and want to make changes to the page that displays them, edit `index.template.php` however you please, then run `./index-update.sh`, which will copy that over to all the correct subdirectories

## enjoy uploading urself to the wired a few kb at a time

### todo
there's a whole bit in post.sh that should be a function but i got lazy
