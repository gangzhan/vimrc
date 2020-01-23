" ###########################################################
" # File Name     : plugins_config.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2018-01-26 08:00
" # Last Modified : 2020-01-16 14:48
" # By            : Mou Tong
" # Description   : plugins config for vim
" ###########################################################

" Plugins List & Config {{{ "

" Plugin List {{{ "

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

" Use plug.vim by default
if !exists('g:rc_use_plug_manager') | let g:rc_use_plug_manager = 1 | endif
if g:rc_use_plug_manager
    if filereadable(expand("~/.vim/autoload/plug.vim"))
        call plug#begin('~/.vim/plugged')

        if version >= 704 || version ==703 && has('patch005')
            Plug 'mbbill/undotree'
        endif
        Plug 'mattn/emmet-vim'
        Plug 'dhruvasagar/vim-table-mode'
        Plug 'machakann/vim-sandwich'
        Plug 'wellle/targets.vim'
        Plug 'kshenoy/vim-signature'
        Plug 'scrooloose/nerdcommenter'
        Plug 'Raimondi/delimitMate'
        Plug 'Yggdroot/indentLine'
        Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
        if version >= 704
            Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
        endif
        Plug 'junegunn/vim-easy-align'
        Plug 'junegunn/goyo.vim'
        Plug 'junegunn/limelight.vim'
        if version >= 704
            Plug 'tpope/vim-fugitive'
        endif
        if version >= 800 || has('nvim')
            Plug 'skywind3000/asyncrun.vim'
            Plug 'mg979/vim-visual-multi'
        endif
        if executable('latexmk')
            Plug 'lervag/vimtex'
        endif
        if !has('win32')
            Plug 'metakirby5/codi.vim'
        endif

        " Appearance
        Plug 'luochen1990/rainbow'
        Plug 'flazz/vim-colorschemes'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'

        " On-demand loading
        Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

        " Lsp Support
        Plug 'dense-analysis/ale'
        if version >= 800 || has('nvim')
            Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
        else
            if version >= 703 && has('lua')
                Plug 'Shougo/neocomplete.vim'
            endif
        endif

        if filereadable(expand("~/.vim/vimrc.plug"))
            source $HOME/.vim/vimrc.plug
        endif

        call plug#end()
    else
        if executable('git')
            call mkdir($HOME . "/.vim/autoload", "p")
            if has('python')
                echo "Downloading plug.vim, please wait a second..."
                exe 'py import os,urllib2; f = urllib2.urlopen("https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"); g = os.path.join(os.path.expanduser("~"), ".vim/autoload/plug.vim"); open(g, "wb").write(f.read())'
            else
                if has('python3')
                    echo "Downloading plug.vim, please wait a second..."
                    exe 'py3 import os,urllib.request; f = urllib.request.urlopen("https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"); g = os.path.join(os.path.expanduser("~"), ".vim/autoload/plug.vim"); open(g, "wb").write(f.read())'
                else
                    exe "silent !echo 'let g:rc_use_plug_manager = 0' > ~/.vim/vimrc.before"
                    echo "WARNING: plug.vim has been disabled due to the absence of 'python' or 'python3' features.\nIf you solve the problem and want to use it, you should delete the line with 'let g:rc_use_plug_manager = 0' in '~/.vim/vimrc.before' file.\nIf you don't take any action, that's OK. This message won't appear again. If you have any trouble contact me."
                endif
            endif
            if filereadable(expand("~/.vim/autoload/plug.vim"))
                echo "PluginManager - plug.vim just installed! vim will quit now.\nYou should relaunch vim, use PlugInstall to install plugins OR do nothing just use the basic config."
                exe 'qall!'
            endif
        else
            exe "silent !echo 'let g:rc_use_plug_manager = 0' > ~/.vim/vimrc.before"
            echo "WARNING: plug.vim has been disabled due to the absence of 'git'.\nIf you solve the problem and want to use it, you should delete the line with 'let g:rc_use_plug_manager = 0' in '~/.vim/vimrc.before' file.\nIf you don't take any action, that's OK. This message won't appear again. If you have any trouble contact me."
        endif
    endif
endif

" }}} Plugin List "

" Plugin Config {{{ "

if g:rc_use_plug_manager && filereadable(expand("~/.vim/autoload/plug.vim"))

    " Plugin Config - vim-colorschemes {{{ "

        if has("gui_running")
            set background=dark
            set transparency=10
            colorscheme solarized
        else
            set background=dark
            let g:solarized_termtrans=1
            let g:solarized_termcolors=256
            let g:solarized_contrast="normal"
            colorscheme solarized
        endif

    " }}} Plugin Config - vim-colorschemes "

   " Plugin Config - undotree {{{ "

    if filereadable(expand("~/.vim/plugged/undotree/plugin/undotree.vim"))
        let g:undotree_SplitWidth         = 40
        let g:undotree_SetFocusWhenToggle = 1
        nmap <silent> <Leader>u :UndotreeToggle<CR>
    endif

    " }}} Plugin Config - undotree "

    " Plugin Config - ultisnips {{{ "

    if filereadable(expand("~/.vim/plugged/ultisnips/plugin/UltiSnips.vim"))
        " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsListSnippets="<C-tab>"
        let g:UltiSnipsJumpForwardTrigger="<C-f>"
        let g:UltiSnipsJumpBackwardTrigger="<C-b>"

        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"

        "UltiSnips will search each 'runtimepath' directory for the subdirectory names
        "defined in g:UltiSnipsSnippetDirectories in the order they are defined. For
        "example, if you keep your snippets in `~/.vim/mycoolsnippets` and you want to
        "make use of the UltiSnips snippets that come with other plugins, add the
        "following to your vimrc file.
        let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
    endif

    " }}} Plugin Config - ultisnips "

    " Plugin Config - emmet-vim {{{ "

    if filereadable(expand("~/.vim/plugged/emmet-vim/plugin/emmet.vim"))
        let g:user_emmet_install_global = 0
        autocmd FileType html,xhtml,xml,css,scss,sass,less EmmetInstall
        let g:user_emmet_leader_key = ','
    endif

    " }}} Plugin Config - emmet-vim "

    " Plugin Config - vim-table-mode {{{ "

    if filereadable(expand("~/.vim/plugged/vim-table-mode/autoload/tablemode.vim"))

        let g:table_mode_auto_align = 0
        autocmd FileType markdown,rst,org :silent TableModeEnable

        autocmd FileType markdown
                    \ let g:table_mode_corner = "|" |
                    \ let g:table_mode_corner_corner = "|" |
                    \ let g:table_mode_header_fillchar = "-" |
                    \ let g:table_mode_align_char = ":"
        autocmd FileType rst
                    \ let g:table_mode_corner = "+" |
                    \ let g:table_mode_corner_corner = "+" |
                    \ let g:table_mode_header_fillchar = "="
        autocmd FileType org
                    \ let g:table_mode_corner = "+" |
                    \ let g:table_mode_corner_corner = "|" |
                    \ let g:table_mode_header_fillchar = "-"
    endif

    " }}} Plugin Config - vim-table-mode "

    " Plugin Config - nerdcommenter {{{ "

    if filereadable(expand("~/.vim/plugged/nerdcommenter/plugin/NERD_commenter.vim"))
        " Always leave a space between the comment character and the comment
        let NERDSpaceDelims = 1
        map <Bslash> <plug>NERDCommenterInvert
        vmap <C-Bslash> <plug>NERDCommenterSexy
    endif

    " }}} Plugin Config - nerdcommenter "

    " Plugin Config - nerdtree {{{ "

    " `S-i` to hide/show the hidden files
    let g:NERDTreeWinPos  = "right"
    let g:NERDTreeWinSize = 35
    let NERDChristmasTree = 1 " Make nerd tree look better

    let NERDTreeCaseSensitiveSort=1 " Make file sorted by case
    let NERDTreeIgnore = ['\.pyc','__pycache__','\~$','\.swp']

    let NERDTreeShowHidden=1

    map <Leader>tr :NERDTreeToggle<cr>
    map <Leader>tb :NERDTreeFromBookmark<Space>
    map <Leader>tf :NERDTreeFind<cr>

    " }}} Plugin Config - nerdtree "

    " Plugin Config - Goyo {{{ "

    if filereadable(expand("~/.vim/plugged/goyo.vim/plugin/goyo.vim"))
        nmap <silent> <C-w><Space> :Goyo<CR>
        function! s:goyo_enter()
            let b:fcstatus = &foldcolumn
            setlocal foldcolumn=0
        endfunction

        function! s:goyo_leave()
            let &foldcolumn = b:fcstatus
        endfunction

        autocmd! User GoyoEnter nested call <SID>goyo_enter()
        autocmd! User GoyoLeave nested call <SID>goyo_leave()
    endif

    " }}} Plugin Config - Goyo "

    " Plugin Config - Limelight {{{ "

    if filereadable(expand("~/.vim/plugged/limelight.vim/plugin/limelight.vim"))
        nmap <silent> <C-w><Enter> :Limelight!!<CR>
        let g:limelight_conceal_ctermfg     = 250
        let g:limelight_default_coefficient = 0.8
    endif

    " }}} Plugin Config - Limelight "

    " Plugin Config - LeaderF {{{ "

    if filereadable(expand("~/.vim/plugged/LeaderF.vim/plugin/LeaderF.vim"))
        " don't show the help in normal mode
        let g:Lf_HideHelp = 1
        let g:Lf_UseCache = 0
        let g:Lf_UseVersionControlTool = 0
        let g:Lf_IgnoreCurrentBufferName = 1
        " popup mode
        let g:Lf_WindowPosition = 'popup'
        let g:Lf_PreviewInPopup = 1
        let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "FuraCode Mono" }
        let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

        let g:Lf_ShortcutF = "<leader>ff"
        noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
        noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
        noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
        noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

        noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
        noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
        " search visually selected text literally
        xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
        noremap go :<C-U>Leaderf! rg --recall<CR>

        " should use `Leaderf gtags --update` first
        let g:Lf_GtagsAutoGenerate = 0
        let g:Lf_Gtagslabel = 'native-pygments'
        noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
        noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
        noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
        noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
        noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
    endif

    " }}} Plugin Config - LeaderF "

    " Plugin Config - vim-easy-align {{{ "

    if filereadable(expand("~/.vim/plugged/vim-easy-align/plugin/easy_align.vim"))
        map <Leader>g :EasyAlign<Space>
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
    endif

    " }}} Plugin Config - vim-easy-align "

    " Plugin Config - airline {{{ "

    if filereadable(expand("~/.vim/plugged/vim-airline/plugin/airline.vim"))
        let g:airline#extensions#tabline#enabled      = 1
        let g:airline#extensions#tabline#left_sep     = ' '
        let g:airline#extensions#tabline#left_alt_sep = '|'
        let g:airline#extensions#tabline#formatter    = 'unique_tail'

        let g:airline_theme           = 'base16'
        let g:airline_powerline_fonts = 1
        let g:airline_solarized_bg    = 'dark'

        let g:airline#extensions#ale#enabled                 = 1

        " Shortkey to change buffer
        "nnoremap <C-N> :bn<CR>
        "nnoremap <C-P> :bp<CR>
    endif

    " }}} Plugin Config - airline "

    " Plugin Config - vimtex {{{ "

    if filereadable(expand("~/.vim/plugged/vimtex/autoload/vimtex.vim"))
        let g:vimtex_compiler_latexmk = {
            \ 'options' : [
            \   '-xelatex',
            \   '-shell-escape',
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}
        " vimtex configuration for neocomplete
        if exists('g:loaded_neocomplete')
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.tex =
                \ g:vimtex#re#neocomplete
        endif
    endif

    " }}} Plugin Config - vimtex "

    " Plugin Config - rainbow {{{ "

    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
    let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}

    " }}} Plugin Config - rainbow "

    " Plugin Config - indentline {{{ "

    let g:indentLine_char_list       = ['|', '¦', '┆', '┊']
    let g:indentLine_enabled         = 1
    let g:autopep8_disable_show_diff = 1

    " }}} Plugin Config - indentline "

    " Plugin Config - visual-multi {{{ "

    let g:VM_mouse_mappings   = 1
    let g:VM_skip_empty_lines = 1
    let g:VM_silent_exit      = 1

    function! VM_Start()
        if exists(":DelimitMateOff") | exe 'DelimitMateOff' | endif
    endfunction

    function! VM_Exit()
        if exists(':DelimitMateOn') | exe 'DelimitMateOn' | endif
    endfunction

    let g:VM_leader = {'default': '<Leader>', 'visual': '<Leader>', 'buffer': 'z'}
    let g:VM_maps                           = {}
    let g:VM_maps["Get Operator"]           = '<Leader>a'
    let g:VM_maps["Add Cursor At Pos"]      = '<Leader><Space>'
    let g:VM_maps["Reselect Last"]          = '<Leader>z'
    let g:VM_maps["Visual Cursors"]         = '<Leader><Space>'
    let g:VM_maps["Undo"]                   = 'u'
    let g:VM_maps["Redo"]                   = '<C-r>'
    let g:VM_maps["Visual Subtract"]        = 'zs'
    let g:VM_maps["Visual Reduce"]          = 'zr'

    " }}} Plugin Config - visual-multi "

    " Plugin Config - coc.nvim {{{ "

    if filereadable(expand("~/.vim/plugged/coc.nvim/plugin/coc.vim"))
        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        vmap <silent> gf <Plug>(coc-format-selected)
        " Remap for rename current word
        nmap gm <Plug>(coc-rename)
        " Show documentation in preview window
        nmap <silent> gh :call CocAction('doHover')<CR>
        nmap <silent> gc :CocList diagnostics<CR>
        nmap <silent> go :CocList outline<CR>
        nmap <silent> gs :CocList -I symbols<CR>
    endif

    " Use coc-explorer for file browsers
    " Install by coc.nvim command:
    " `CocInstall coc-explorer`

    " coc config - explorer {{{ "

        :nmap ge :CocCommand explorer<CR>

    " }}} coc config - explorer "

    " }}} Plugin Config - coc.nvim "

    " Plugin Config - neocomplete {{{ "

    if filereadable(expand("~/.vim/plugged/neocomplete.vim/plugin/neocomplete.vim"))
        let g:neocomplete#enable_at_startup = 1
    else
        set omnifunc=syntaxcomplete#Complete
    endif

    " }}} Plugin Config - neocomplete "

    " Plugin Config - ale {{{ "

    let g:ale_set_highlights = 0
    let g:ale_fix_on_save = 1
    let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'
    let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

    let g:ale_sign_error = '•'
    let g:ale_sign_warning = '•'

    let g:ale_completion_delay = 500
    let g:ale_echo_delay = 20
    let g:ale_lint_delay = 500
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1

    nmap <Leader>an <Plug>(ale_next)
    nmap <Leader>ap <Plug>(ale_previous)
    nnoremap <Leader>ts :ALEToggle<CR>

    " }}} Plugin Config - ale "

endif

" }}} Plugin Config "

" }}} Plugins List & Config "
