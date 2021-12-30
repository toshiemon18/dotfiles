let g:ale_linters = {
			\ 'javascript': ['eslint'],
			\ 'ruby': ['rubocop']
			\ }
let g:ale_fixers = {
			\ 'javascript': ['prettier'],
			\ 'python': ['autopep8', 'isort'],
			\ 'ruby': ['rubocop']
			\ }
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 0
let g:ale_linters_explicit = 1
