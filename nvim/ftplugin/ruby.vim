augroup RSpec
    autocmd!
    autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby
autocmd BufNewFile,BufRead Guardfile  set filetype=ruby
autocmd BufNewFile,BufRead .pryrc     set filetype=ruby
autocmd BufNewFile,BufRead Schemafile set filetype=ruby
autocmd BufNewFile,BufRead Rakefile   set filetype=ruby

set iskeyword+=?      " RubyでBool値返すメソッドをちゃんと判断させる
set nocindent
set autoindent
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
