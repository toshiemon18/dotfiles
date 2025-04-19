# Neovim Keymap

## 基本操作

| キー | モード | 説明 | コマンド |
|------|--------|------|----------|
| `;` | Normal | コマンドモードに切り替え | `:` |
| `<C-j><C-j>` | Normal | 検索ハイライトを解除 | `:nohlsearch` |
| `vn` | All | 垂直分割で新しいバッファを開く | `:vnew` |
| `<S-h>` | All | 行頭に移動 | `^` |
| `<S-l>` | All | 行末に移動 | `$` |

## インデント操作

| キー | モード | 説明 | コマンド |
|------|--------|------|----------|
| `>` | Visual | インデントを増やす（選択状態を維持） | `>gv` |
| `<` | Visual | インデントを減らす（選択状態を維持） | `<gv` |

## Telescope

| キー | モード | 説明 | コマンド |
|------|--------|------|----------|
| `<leader>tf` | Normal | ファイル検索 | `Telescope find_files` |
| `<leader>tr` | Normal | テキスト検索 | `Telescope live_grep` |
| `<leader>tb` | Normal | バッファ一覧 | `Telescope buffers` |
| `<leader>tk` | Normal | キーマップ検索 | `Telescope keymaps` |
| `<leader>ta` | Normal | コマンド検索 | `Telescope commands` |
| `<leader>d` | Normal | 診断情報一覧 | `Telescope diagnostics` |
| `<leader>ts` | Normal | ファイルブラウザ | `Telescope file_browser` |

## NvimTree

| キー | モード | 説明 | コマンド |
|------|--------|------|----------|
| `<leader>f` | Normal | ツリーの表示/非表示 | `NvimTreeToggle` |
| `<leader><C-1>` | Normal | ツリーにフォーカス | `NvimTreeFocus` |
| `l` | Normal | ファイルを開く | `api.node.open.edit` |
| `h` | Normal | ディレクトリを閉じる | `api.node.navigate.parent_close` |
| `?` | Normal | ヘルプを表示 | `api.tree.toggle_help` |
| `<S-e>` | Normal | 垂直分割で開く | `api.node.open.vertical` |
| `i` | Normal | 水平分割で開く | `api.node.open.horizontal` |

## LSP

| キー | モード | 説明 | コマンド |
|------|--------|------|----------|
| `<leader>aa` | Normal | 診断情報を表示 | `vim.diagnostic.open_float` |
| `dl` | Normal | ロケーションリストに診断を追加 | `vim.diagnostic.setloclist` |
| `K` | Normal | ホバー情報を表示 | `vim.lsp.buf.hover` |
| `gd` | Normal | 定義に移動 | `Telescope lsp_definitions` |
| `gi` | Normal | 実装に移動 | `vim.lsp.buf.implementation` |
| `gD` | Normal | 宣言に移動 | `vim.lsp.buf.declaration` |
| `go` | Normal | 型定義に移動 | `vim.lsp.buf.type_definition` |
| `gr` | Normal | 参照を検索 | `Telescope lsp_references` |
| `gy` | Normal | 型定義に移動 | `vim.lsp.buf.type_definition` |
| `<C-s>` | Normal | シグネチャヘルプを表示 | `vim.lsp.buf.signature_help` |
| `<space>gf` | Normal | コードをフォーマット | `vim.lsp.buf.format` |

## 補完

| キー | モード | 説明 | コマンド |
|------|--------|------|----------|
| `<C-n>` | Insert | 次の候補を選択 | `cmp.mapping.select_next_item` |
| `<C-p>` | Insert | 前の候補を選択 | `cmp.mapping.select_prev_item` |
| `<C-d>` | Insert | ドキュメントを上にスクロール | `cmp.mapping.scroll_docs(-4)` |
| `<C-f>` | Insert | ドキュメントを下にスクロール | `cmp.mapping.scroll_docs(4)` |
| `<C-Space>` | Insert | 補完を開始 | `cmp.mapping.complete` |
| `<C-e>` | Insert | 補完を閉じる | `cmp.mapping.close` |
| `<CR>` | Insert | 選択した候補を確定 | `cmp.mapping.confirm` |
| `<TAB>` | Insert | 選択した候補を確定 | `cmp.mapping.confirm` | 