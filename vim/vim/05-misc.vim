" w!! forces writing as sudo when insufficient priveleges
cmap w!! %!sudo tee > /dev/null %

" show git diff in vsplit with git commit
autocmd FileType gitcommit DiffGitCached | wincmd L | wincmd p

" strip trailing whitespace on save, in python
autocmd FileType c,cpp,python,ruby,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e

" Autocorrect words / spelling mistakes
iab teh the
iab Teh The
