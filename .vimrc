execute pathogen#infect()
filetype plugin indent on
colorscheme evening  
syntax on
set number 
set tabstop=4
set softtabstop=4
set shiftwidth=4
set number
set expandtab
set ruler
set laststatus=2
set showmatch
set fileencodings=ucs-born,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1


func! CompileGcc()
    exec "w"
    let compilecmd="!gcc "
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpicc "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc
func! CompileGpp()
    exec "w"
    let compilecmd="!g++ "
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpic++ "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc

func! RunPython()
        exec "!python %"
endfunc

func! RunPython3()
    exec "!python3 %"
endfunc

func! CompileJava()
    exec "!javac %"
endfunc


func! CompileCode()
        exec "w"
        if &filetype == "cpp"
                exec "call CompileGpp()"
        elseif &filetype == "c"
                exec "call CompileGcc()"
        elseif &filetype == "python"
                exec "call RunPython()"
        elseif &filetype == "java"
                exec "call CompileJava()"
        endif
endfunc

func! RunResult()
        exec "w"
        if search("mpi\.h") != 0
            exec "!mpirun -np 4 ./%<"
        elseif &filetype == "cpp"
            exec "! ./%<"
        elseif &filetype == "c"
            exec "! ./%<"
        elseif &filetype == "python"
            exec "call RunPython"
        elseif &filetype == "java"
            exec "!java %<"
        endif
endfunc

map <F5> :call CompileCode()<CR>
imap <F5> <ESC>:call CompileCode()<CR>
vmap <F5> <ESC>:call CompileCode()<CR>
map <F7> :call RunPython3()<CR>
map <F6> :call RunResult()<CR>


"< F9> 编译运行C
map <f9> :call ComplieRunGpp()<cr>
func! ComplieRunGpp()
    exec "w"
    exec “!g++ % -o % -< -Wall -std=c++11"
    exec "!./%<"
endfunc

