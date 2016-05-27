filetype off

" Setup NeoBundle - The hard way, without using submodules!
if has('vim_starting')
    " Install the bundles after we have installed neo bundle
    let s:install_neo_bundles = 0

    " Clone and or Load NeoBundle
    let s:neobundle_dir = expand('~/.vim/bundle')
    if isdirectory('neobundle.vim')
        set runtimepath^=neobundle.vim
    elseif finddir('neobundle.vim', '.;') != ''
        execute 'set runtimepath^=' . finddir('neobundle.vim', '.;')
    elseif &runtimepath !~ '/neobundle.vim'
        if !isdirectory(s:neobundle_dir.'/neobundle.vim')
            execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
                        \ (exists('$http_proxy') ? 'https' : 'git'))
                        \ s:neobundle_dir.'/neobundle.vim'
            let s:install_neo_bundles = 1
        endif

        execute 'set runtimepath^=' . s:neobundle_dir.'/neobundle.vim'
    endif

    let g:neobundle#enable_tail_path = 1
    let g:neobundle#types#git#default_protocol = 'https'
    let g:neobundle#install_process_timeout = 480
    call neobundle#begin(s:neobundle_dir)
endif

" Allow NeoBundle to update itself O.o
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tomasr/molokai'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-surround'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'majutsushi/tagbar'

" Language plugins
NeoBundle 'solarnz/arcanist.vim'
NeoBundle 'solarnz/thrift.vim'
NeoBundle "groenewege/vim-less"
NeoBundle "rodjek/vim-puppet"
NeoBundle "fatih/vim-go"
NeoBundle "rust-lang/rust.vim"
NeoBundle "davidhalter/jedi-vim"

call neobundle#end()

if has('vim_starting') && s:install_neo_bundles == 1
    NeoBundleInstall
endif
