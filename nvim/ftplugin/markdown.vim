" =======================
"        Markdown
" =======================
augroup markdown
    au!
    " au BufNewFile, BufRead *.md, *.markdown setl filetype=gmarkdown
		au BufNewFile, BufRead *.md setl filetype=markdown
augroup END
autocmd FileType markdown setl autoindent smartindent expandtab nocindent
autocmd FileType markdown setl tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType gmarkdown setl autoindent smartindent expandtab nocindent
autocmd FileType gmarkdown setl tabstop=2 softtabstop=2 shiftwidth=2
