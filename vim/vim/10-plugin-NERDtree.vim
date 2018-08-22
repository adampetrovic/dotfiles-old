autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" <C-n> to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
