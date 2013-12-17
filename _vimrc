set nocompatible
filetype off
" �˴��涨Vundle��·��
set rtp+=$VIM/vimfiles/bundle/vundle/
call vundle#rc('$VIM/vimfiles/bundle/')
Bundle 'gmarik/vundle'
filetype plugin indent on

 
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'bufexplorer.zip'
Bundle 'taglist.vim'
Bundle 'The-NERD-tree'
Bundle 'matrix.vim'
Bundle 'The-NERD-Commenter'
Bundle 'Lokaltog/vim-powerline'
Bundle 'OmniCppComplete'

 
filetype plugin indent on     " required! 


"��˵�е�ȥ���߿����±���һ�� 
set go= 
"������ɫ������ѡ�����desert��Ҳ��������������vim������:color ����tab�����Բ鿴 
color evening 
"���ñ���ɫ��ÿ����ɫ�����ַ�����һ��light��һ��dark 
set background=dark 
"��ʾ�к� 
set number 
" �����ݼ���ǰ׺����<Leader>
let mapleader=";"
let g:mapleader = ";"
"ѡ������۵�����
set foldmethod=syntax
"����vim ʱ��Ҫ�Զ��۵�����
set foldlevel=100



if(has("win32") || has("win95") || has("win64") || has("win16")) "�ж���ǰ����ϵͳ����
    let g:iswindows=1
else
    let g:iswindows=0
endif
set nocompatible "��Ҫvimģ��viģʽ���������ã�������кܶ಻���ݵ�����
syntax on"�򿪸���
if has("autocmd")
    filetype plugin indent on "�����ļ���������
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
else
    "������������Ӧ����cindent���ٷ�˵autoindent����֧�ָ����ļ�������������Ч�����ֻ֧��C/C++��cindentЧ�����һ�㣬�����߲�û�п�����
    set autoindent " always set autoindenting on 
endif " has("autocmd")
set tabstop=4 "��һ��tab����4���ո�
set vb t_vb=
set nowrap "���Զ�����
set hlsearch "������ʾ���
set incsearch "������Ҫ����������ʱ��vim��ʵʱƥ��
set backspace=indent,eol,start whichwrap+=<,>,[,] "�����˸����ʹ��
if(g:iswindows==1) "��������ʹ��
    "��ֹlinux�ն����޷�����
    if has('mouse')
        set mouse=a
    endif
    au GUIEnter * simalt ~x
endif
"���������
set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI "��ס�ո����»��ߴ���Ŷ
set gfw=��Բ:h10:cGB2312

set tags=tags;
set autochdir
set  cscopetag


"CTags&Cscope����
map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

"����Tlist������
"TlistUpdate���Ը���tags
map <F3> :silent! Tlist<CR> "����F3�Ϳ��Ժ�����
let Tlist_Ctags_Cmd='ctags' "��Ϊ���Ƿ��ڻ�����������Կ���ֱ��ִ��
let Tlist_Use_Right_Window=0 "�ô�����ʾ���ұߣ�0�Ļ�������ʾ�����
let Tlist_Show_One_File=0 "��taglist����ͬʱչʾ����ļ��ĺ����б��������ֻ��1��������Ϊ1
let Tlist_File_Fold_Auto_Close=1 "�ǵ�ǰ�ļ��������б��۵�����
let Tlist_Exit_OnlyWindow=1 "��taglist�����һ���ָ��ʱ���Զ��Ƴ�vim
let Tlist_Process_File_Always=1 "�Ƿ�һֱ����tags.1:����;0:������������һֱʵʱ����tags����Ϊû�б�Ҫ
let Tlist_Inc_Winwidth=0
" ��Ҫ�ر������ļ���tags 
let Tlist_File_Fold_Auto_Close = 0 
" ��Ҫ��ʾ�۵��� 
let Tlist_Enable_Fold_Column = 0 

"NERD Tree
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeBookmarksFile=$VIM.'\Data\NerdBookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='right'
let NERDTreeWinSize=31
map <F4> :silent! NERDTreeToggle ar<CR> "����F3�Ϳ��Ժ�����



"vim-powerline
set laststatus=2
set guifont=PowerlineSymbols\ for\ Powerline
set t_Co=256
let g:Powerline_symbols = 'fancy'

" �ÿո���������۵� 
set foldenable 
set foldmethod=manual 
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR> 

" �趨Ĭ�Ͻ��� 
set fenc=utf-8 
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936 

" history�ļ�����Ҫ��¼������ 
set history=1000 
" �ڴ���δ�����ֻ���ļ���ʱ�򣬵���ȷ�� 
set confirm 

" ��windows���������� 
set clipboard+=unnamed 

" ����ȫ�ֱ��� 
set viminfo+=! 

" ������ʱ����ʾ�Ǹ�Ԯ���������ͯ����ʾ 
set shortmess=atI 

" ������ʾƥ������� 
set showmatch 
" ƥ�����Ÿ�����ʱ�䣨��λ��ʮ��֮һ�룩 
set matchtime=5 

" ��������ʱ����Դ�Сд 
set ignorecase 

syntax enable
syntax on

"
nnoremap <Leader>n :set nohlsearch<CR> 















































"
"set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
"
"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction
"
"