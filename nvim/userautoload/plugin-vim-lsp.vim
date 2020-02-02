" ========================
"        vim-lsp
" ========================

" デバッグ設定
let g:lsp_log_verbose=1 " デバッグログを出力する
if !isdirectory(expand('~/.cache/tmp'))
	call mkdir(expand('~/.cache/tmp', 'p'))
end
let g:lsp_log_file=expand('~/.cache/tmp/vim-lsp.log') " vim-lspのデバッグ用ログファイル

" 基本設定
let g:lsp_preview_keep_focus=0
let g:lsp_preview_float=1
let g:lsp_preview_autoclose=1

" 言語毎の設定
augroup MyLSP
	autocmd!
	" for Python3 LSP
	" if execute('pyls')
	" 	autocmd User lsp_setup call lsp#register_server({
	" 				\ 'name': 'pyls',
	" 				\ 'cmd': { server_info -> ['pyls'] },
	" 				\ 'whitelist': ['python'],
	" 				\	'workspace_config': {
	" 				\   'pyls': {
	" 				\				'plugins': {
	" 				\					'pycodestyle': { 'enabled': v:false },
	" 				\					'jedi-definition': { 'follow_imports': v:true, 'follow_builtin_imports': v:true }
	" 				\				}
	" 				\			}
	" 				\		}
	" 				\ })
	" 	autocmd FileType python call s:configure_lsp()
	" endif

	" for Ruby LSP using solargraph
	if (executable('solargraph'))
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'solargraph',
					\	'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
					\ 'initialization_options': { "diagnostics": v:true },
					\ 'whitelist': ['ruby', 'slim', 'rspec']
					\})
	endif

	" terraform-lsp
	" terraform用のLSPを使うよ
	if executable('terraform-lsp')
		autocmd User lsp_setup call lsp#register_server({
			\ 'name': 'terraform-lsp',
			\ 'cmd': {server_info->[&shell, &shellcmdflag, 'terraform-lsp']},
			\ 'whitelist': ['terraform','tf'],
			\ })
	endif
augroup END

function! s:configure_lsp() abort
	setlocal omnifunc=lsp#complete " オムニ保管の有効化
	setlocal signcolumn=yes

	" keybinds
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> RN <plug>(lsp-rename)
	" ESCでvim-lspのfloat windowを閉じる
	autocmd User lsp_float_opened nmap <buffer> <silent> <esc>
		      \ <Plug>(lsp-preview-close)
	autocmd User lsp_float_closed nunmap <buffer> <esc>
endfunction

augroup lsp_install
	autocmd!
	autocmd User lsp_buffer_enabled call s:configure_lsp()
augroup END
