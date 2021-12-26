" =================
"   RSpec.vim
" =================
nnoremap [rspec] <Nop>
nmap <Space>0 [rspec]
nmap [rspec]t :call RunCurrentSpecFile()<CR>
nmap [rspec]s :call RunNearestSpec()<CR>
nmap [rspec]l :call RunLastSpec()<CR>
nmap [rspec]a :call RunAllSpecs()<CR>
