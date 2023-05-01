" Vim supports hierarchical filetypes using a dot between the filetypes. This
" means - first use groovy and then gradle.
au! BufRead,BufNewFile *.gradle set filetype=groovy.gradle
