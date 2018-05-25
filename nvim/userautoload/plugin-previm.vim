" ==========
"  previm
" ==========

" Use open-browser.vim

let g:previm_disable_default_css = 1
let g:previm_custom_css_path = "~/dotfiles/nvim/ftplugin/gh_markdown.templete.css"

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
