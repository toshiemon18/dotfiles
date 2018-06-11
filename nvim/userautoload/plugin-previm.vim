" ==========
"  previm
" ==========

" Use open-browser.vim

let g:previm_disable_default_css = 1
let g:previm_custom_css_path = "~/dotfiles/nvim/ftplugin/gh_markdown.templete.css"
let g:previm_open_cmd = "open -a Google\ Chrome"

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
