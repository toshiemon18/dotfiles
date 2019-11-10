" ========================
"        vim-lsp
" ========================

" デバッグ設定
let g:lsp_log_verbose=1 " デバッグログを出力する
let g:lsp_log_file=expand('~/.cache/tmp/vim-lsp.log') " vim-lspのデバッグ用ログファイル

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
	if executable('solargraph')
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'solargraph',
					\	'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
					\ 'initialization_options': { "diagnostics": v:true },
					\ 'whitelist': ['ruby', 'slim', 'rspec']
					\})
	endif
augroup END

function! s:configure_lsp() abort
	setlocal omnifunc=lsp#complete " オムニ保管の有効化
endfunction

