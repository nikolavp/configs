iabbrev <buffer> jci const_iterator
iabbrev <buffer> jcl class
iabbrev <buffer> jco const
iabbrev <buffer> jdx /**<CR><CR>/<Up>
iabbrev <buffer> jit iterator
iabbrev <buffer> jns namespace
iabbrev <buffer> jpr protected
iabbrev <buffer> jpu public
iabbrev <buffer> jpv private
iabbrev <buffer> jsl std::list<><ESC>i
iabbrev <buffer> jsm std::map<><ESC>i
iabbrev <buffer> jsp std::tr1::shared_ptr<><ESC>i
iabbrev <buffer> jss std::string
iabbrev <buffer> jsv std::vector<><ESC>i
iabbrev <buffer> jty typedef
iabbrev <buffer> jun using namespace
iabbrev <buffer> jvi virtual
iabbrev <buffer> jt1 std::tr1::
iabbrev <buffer> cout std::cout<space><<;<esc>i
iabbrev <buffer> cin std::cin<space>>>;<esc>i
"call IMAP("endl", "<< std::endl", "cpp")


"Automatic curly braces it is sometimes annoying for comments but overall
"nice"
map <buffer> <S-F7> :!./a.out<CR>
"Don't indent public,private,protected
set cino=g0
fun! Cmake(...)
    let builddir = finddir("Build", ".;")
    if builddir == ""
        echo "There is no Build directory in the root tree"
        return
    endif
    if a:0 == 1
        if a:1 == "clean"
            execute "!rm -rf ".builddir."/*"
        endif
    endif
    if !filereadable(builddir. "//CMakeCache.txt")
        execute "!cd ".builddir.";cmake ../"
    endif
    let buildcommand = "make\\ -C\\ " . builddir . "\\ VERBOSE=1"
    execute "set makeprg=" . buildcommand
    unlet builddir
endfun
command! -nargs=? Cmake :call Cmake(<f-args>)
set path=.,/usr/include,/usr/local/include,
if $QTDIR != ''
    let &path = &path . $QTDIR . '/include/,'
    let &path = &path . $QTDIR . '/include/Qt/,'
    let &path = &path . $QTDIR . '/include/QtCore/,'
    let &path = &path . $QTDIR . '/include/Qt3Support/,'
    let &path = &path . $QTDIR . '/include/QtAssistant/,'
    let &path = &path . $QTDIR . '/include/QtDBus/,'
    let &path = &path . $QTDIR . '/include/QtDesigner/,'
    let &path = &path . $QTDIR . '/include/QtGui/,'
    let &path = &path . $QTDIR . '/include/QtNetwork/,'
    let &path = &path . $QTDIR . '/include/QtOpenGL/,'
    let &path = &path . $QTDIR . '/include/QtSql/,'
    let &path = &path . $QTDIR . '/include/QtSvg/,'
    let &path = &path . $QTDIR . '/include/QtTest/,'
    let &path = &path . $QTDIR . '/include/QtUiTools/,'
    let &path = &path . $QTDIR . '/include/QtXml/,'
endif
if $KDEDIR != ''
    let &path = &path . $KDEDIR . '/include/,'
endif
if $KDEDIRS != ''
    let &path = &path . substitute( $KDEDIRS, '\(:\|$\)', '/include,', 'g' )
endif
set path+=,
" Insert an #include statement for the current/last symbol
inoremap <F5> <C-O>:call AddHeader()<CR>
" Insert a forward declaration for the current/last symbol
inoremap <S-F5> <C-O>:call AddForward()<CR>
" Switch between header and implementation files on ,h
nmap <silent> ,h :call SwitchHeaderImpl()<CR>
nmap <silent> ,p :call SwitchPrivateHeaderImpl()<CR>
nmap ,i :call IncludeGuard()<CR>
" Expand #i to #include <.h> or #include ".h". The latter is chosen
" if the character typed after #i is a dquote
" If the character is > #include <> is inserted (standard C++ headers w/o .h)
iab #i <C-R>=SmartInclude()<CR>
function! SwitchHeaderImpl()
    let privateheaders = '_p\.\([hH]\|hpp\|hxx\)$'
    let headers = '\.\([hH]\|hpp\|hxx\)$'
    let impl = '\.\([cC]\|cpp\|cc\|cxx\)$'
    let fn = expand( '%' )
    if fn =~ privateheaders
        let list = glob( substitute( fn, privateheaders, '.*', '' ) )
    elseif fn =~ headers
        let list = glob( substitute( fn, headers, '.*', '' ) )
    elseif fn =~ impl
        let list = glob( substitute( fn, impl, '.*', '' ) )
    endif
    while strlen( list ) > 0
        let file = substitute( list, "\n.*", '', '' )
        let list = substitute( list, "[^\n]*", '', '' )
        let list = substitute( list, "^\n", '', '' )
        if ( ( fn =~ headers || fn =~ privateheaders ) && file =~ impl ) || ( fn =~ impl && file =~ headers )
            call AskToSave()
            execute( "edit " . file )
            return
        endif
    endwhile
    if ( fn =~ headers )
        call AskToSave()
        if exists( "$implextension" )
            let file = substitute( fn, headers, '.' . $implextension, '' )
        else
            let file = substitute( fn, headers, '.cpp', '' )
        endif
        " check for modified state of current buffer and if modified ask:
        " save, discard, cancel
        execute( 'edit '.file )
        call append( 0, "#include \"".fn."\"" )
        call append( 2, "// vim: sw=4 sts=4 et tw=100" )
        execute( "set sw=4" )
        execute( "set sts=4" )
        execute( "set et" )
        execute( "set tw=100" )
    elseif fn =~ impl
        call AskToSave()
        let file = substitute( fn, impl, '.h', '' )
        execute( "edit ".file )
    endif
endfunction

function! SwitchPrivateHeaderImpl()
    let privateheaders = '_p\.\([hH]\|hpp\|hxx\)$'
    let headers = '\.\([hH]\|hpp\|hxx\)$'
    let impl = '\.\([cC]\|cpp\|cc\|cxx\)$'
    let fn = expand( '%' )
    if fn =~ privateheaders
        let list = glob( substitute( fn, privateheaders, '.*', '' ) )
    elseif fn =~ headers
        let list = glob( substitute( fn, headers, '_p.*', '' ) )
    elseif fn =~ impl
        let list = glob( substitute( fn, impl, '_p.*', '' ) )
    endif
    while strlen( list ) > 0
        let file = substitute( list, "\n.*", '', '' )
        let list = substitute( list, "[^\n]*", '', '' )
        let list = substitute( list, "^\n", '', '' )
        if ( fn =~ privateheaders && file =~ impl ) || ( fn =~ impl && file =~ privateheaders ) || ( fn =~ headers && file =~ privateheaders )
            call AskToSave()
            execute( "edit " . file )
            return
        endif
    endwhile
    if ( fn =~ privateheaders )
        call AskToSave()
        if exists( "$implextension" )
            let file = substitute( fn, privateheaders, '.' . $implextension, '' )
        else
            let file = substitute( fn, privateheaders, '.cpp', '' )
        endif
        " check for modified state of current buffer and if modified ask:
        " save, discard, cancel
        execute( 'edit '.file )
        call append( 0, "#include \"".fn."\"" )
        call append( 2, "// vim: sw=4 ts=4 noet" )
        execute( "set sw=4" )
        execute( "set ts=4" )
    elseif fn =~ impl
        let file = substitute( fn, impl, '_p.h', '' )
        call CreatePrivateHeader( file )
    elseif fn =~ headers
        let file = substitute( fn, headers, '_p.h', '' )
        call CreatePrivateHeader( file )
    endif
endfunction
function! AskToSave()
    if &modified
        let yesorno = input("Save changes before switching file? [Y/n]")
        if yesorno == 'y' || yesorno == '' || yesorno == 'Y'
            :execute 'w'
            return 1
        else
            return 0
        endif
    endif
    return 1
endfunction
function! IncludeGuard()
    let guard = toupper( substitute( expand( '%' ), '[\./]', '_', 'g' ) )
    call append( '^', '#define ' . guard )
    +
    call append( '^', '#ifndef ' . guard )
    call append( '$', '#endif // ' . guard )
    +
endfunction
function! SmartInclude()
    let next = nr2char( getchar( 0 ) )
    if next == '"'
        return "#include \".h\"\<Left>\<Left>\<Left>"
    endif
    if next == '>'
        return "#include <>\<Left>"
    endif
    return "#include <.h>\<Left>\<Left>\<Left>"
endfunction
function! MapIdentHeader( ident )
    let header = tolower(substitute(a:ident, '::', '/', 'g')).'.h'
    if a:ident =~ 'Private$'
        let header = substitute(header, 'private', '_p', '')
    endif
    " always prefer the headers in the same directory
    let check = header
    let slash = 1
    while slash != -1
        if filereadable( check )
            return '"' . check . '"'
        endif
        let slash = match( check, '/' )
        let check = strpart( check, slash + 1 )
    endwhile
    let check = tolower(substitute(a:ident, '::', '/', 'g')).'_p.h'
    let slash = 1
    while slash != -1
        if filereadable(check)
            return '"' . check . '"'
        endif
        let slash = match(check, '/')
        let check = strpart(check, slash + 1)
    endwhile

    " Qt stuff
    if a:ident =~ '^Q[A-Z]'
        " let's try to find the module
        let module = ''
        if $QTDIR != ''
            if filereadable($QTDIR.'/include/QtCore/'.a:ident)
                let module = 'QtCore/'
            elseif filereadable($QTDIR.'/include/QtGui/'.a:ident)
                let module = 'QtGui/'
            elseif filereadable($QTDIR.'/include/Qt3Support/'.a:ident)
                let module = 'Qt3Support/'
            elseif filereadable($QTDIR.'/include/QtAssistant/'.a:ident)
                let module = 'QtAssistant/'
            elseif filereadable($QTDIR.'/include/QtDBus/'.a:ident)
                let module = 'QtDBus/'
            elseif filereadable($QTDIR.'/include/QtDesigner/'.a:ident)
                let module = 'QtDesigner/'
            elseif filereadable($QTDIR.'/include/QtNetwork/'.a:ident)
                let module = 'QtNetwork/'
            elseif filereadable($QTDIR.'/include/QtOpenGL/'.a:ident)
                let module = 'QtOpenGL/'
            elseif filereadable($QTDIR.'/include/QtSql/'.a:ident)
                let module = 'QtSql/'
            elseif filereadable($QTDIR.'/include/QtSvg/'.a:ident)
                let module = 'QtSvg/'
            elseif filereadable($QTDIR.'/include/QtTest/'.a:ident)
                let module = 'QtTest/'
            elseif filereadable($QTDIR.'/include/QtUiTools/'.a:ident)
                let module = 'QtUiTools/'
            elseif filereadable($QTDIR.'/include/QtXml/'.a:ident)
                let module = 'QtXml/'
            endif
        endif
        return '<'.module.a:ident.'>'
    elseif a:ident == 'qDebug' ||
          \a:ident == 'qWarning' ||
          \a:ident == 'qCritical' ||
          \a:ident == 'qFatal'
        return '<QtCore/QtDebug>'
    elseif a:ident == 'Q_EXPORT_PLUGIN2'
        return '<QtCore/QtPlugin>'
    elseif a:ident =~ 'Q_DECLARE_INTERFACE'
        return '<QtCore/QObject>'
    elseif a:ident =~ '^QT_VERSION' ||
          \a:ident =~ '^Q_\(W\|O\)S_' ||
          \a:ident =~ '^Q_CC_' ||
          \a:ident =~ '^Q_.*STRUCTOR_FUNCTION$' ||
          \a:ident =~ '^qu\?int' ||
          \a:ident =~ '^Q_.*_RESOURCE$' ||
          \a:ident == 'qreal' ||
          \a:ident == 'qAbs' ||
          \a:ident == 'qRound' ||
          \a:ident == 'qRound64' ||
          \a:ident == 'qMin' ||
          \a:ident == 'qMax' ||
          \a:ident == 'qBound' ||
          \a:ident == 'qVersion' ||
          \a:ident == 'qSharedBuild' ||
          \a:ident == 'Q_UNUSED' ||
          \a:ident == 'Q_ASSERT' ||
          \a:ident == 'qInstallMsgHandler' ||
          \a:ident == 'Q_GLOBAL_STATIC' ||
          \a:ident == 'Q_GLOBAL_STATIC_WITH_ARGS' ||
          \a:ident == 'qFuzzyCompare' ||
          \a:ident == 'qIsNull' ||
          \a:ident == 'qSwap' ||
          \a:ident =~ 'Q_DECLARE_\(FLAGS\|OPERATORS_FOR_FLAGS\|PRIVATE\|PUBLIC\)' ||
          \a:ident == 'Q_D' ||
          \a:ident == 'Q_Q' ||
          \a:ident == 'Q_DISABLE_COPY' ||
          \a:ident == 'qsrand' ||
          \a:ident == 'qrand'
        return '<QtCore/QtGlobal>'

    " Phonon stuff
    elseif a:ident =~ '^Phonon::[A-Z]'
        if a:ident =~ '^Phonon::\(NoDisc\|Cd\|Dvd\|Vcd\|.\+MetaData\|.*State\|.*Category\|.\+Error\)'
            return '<Phonon/Global>'
        endif
        return '<'.substitute(a:ident, '::', '/', 'g').'>'
    endif

    " KDE stuff
    let kdeincdir = substitute(system('kde4-config --prefix'), '[\n\r]*', '', 'g').'/include/KDE/'
    let classname = substitute(a:ident, '^.*:', '', '')
    let pathfn = expand('%:p:h')
    if filereadable(kdeincdir.classname) && !pathfn =~ 'kdelibs'
        return '<'.classname.'>'
    elseif filereadable(kdeincdir.'Phonon/'.classname)
        return '<Phonon/'.classname.'>'
    elseif filereadable(kdeincdir.'Solid/'.classname)
        return '<Solid/'.classname.'>'
    elseif filereadable(kdeincdir.'KIO/'.classname)
        return '<KIO/'.classname.'>'
    elseif filereadable(kdeincdir.'KParts/'.classname)
        return '<KParts/'.classname.'>'
    elseif a:ident == 'K_GLOBAL_STATIC'
        return '<KGlobal>'
    elseif a:ident == 'K_EXPORT_PLUGIN'
        return '<KPluginLoader>'
    elseif a:ident =~ 'K_PLUGIN_FACTORY'
        return '<KPluginFactory>'
    elseif a:ident == 'K\(Double\|Int\)\(NumInput\|SpinBox\)'
        return '<knuminput.h>'
    elseif a:ident == 'KSharedConfig'
        return '<kconfig.h>'
    elseif a:ident == 'KConfigGroup'
        return '<kconfiggroup.h>'
    elseif a:ident == 'KListViewItem'
        return '<klistview.h>'
    elseif a:ident =~ 'kd\(Debug\|Warning\|Error\|Fatal\|Backtrace\)'
        return '<kdebug.h>'
    elseif a:ident == 'kapp'
        return '<kapplication.h>'
    elseif a:ident == 'i18n' ||
          \a:ident == 'I18N_NOOP'
        return '<klocale.h>'
    elseif a:ident == 'locate' ||
          \a:ident == 'locateLocal'
        return '<kstandarddirs.h>'
    elseif a:ident =~ '\(Small\|Desktop\|Bar\|MainBar\|User\)Icon\(Set\)\?' ||
          \a:ident == 'IconSize'
        return '<kiconloader.h>'

    " aRts stuff
    elseif a:ident =~ '\arts_\(debug\|info\|warning\|fatal\)'
        return '<debug.h>'

    " Standard Library stuff
    elseif a:ident =~ '\(std::\)\?\(cout\|cerr\|endl\)'
        return '<iostream>'
    elseif a:ident =~ '\(std::\)\?is\(alnum\|alpha\|ascii\|blank\|graph\|lower\|print\|punct\|space\|upper\|xdigit\)'
        return '<cctype>'
    elseif a:ident == 'printf'
        return '<cstdio>'
    endif

    let check = header
    while 1
        if filereadable( check )
            return '"' . check . '"'
        endif
        let slash = match( check, '/' )
        if slash == -1
            return '<' . header . '>'
        endif
        let check = strpart( check, slash + 1 )
    endwhile
endfunction
" This is a rather dirty hack, but seems to work somehow :-) (malte)
function! AddHeader()
    let s = getline( '.' )
    let i = col( '.' ) - 1
    while i > 0 && strpart( s, i, 1 ) !~ '[A-Za-z0-9_:]'
        let i = i - 1
    endwhile
    while i > 0 && strpart( s, i, 1 ) =~ '[A-Za-z0-9_:]'
        let i = i - 1
    endwhile
    let start = match( s, '[A-Za-z0-9_]\+\(::[A-Z][A-Za-z0-9_]*\)*', i )
    let end = matchend( s, '[A-Za-z0-9_]\+\(::[A-Z][A-Za-z0-9_]*\)*', i )
"    if end > col( '.' )
"        let end = matchend( s, '[A-Za-z0-9_]\+', i )
"    endif
    let ident = strpart( s, start, end - start )
    let header = MapIdentHeader(ident)
    let include = '#include '.header

    let line = 1
    let incomment = 0
    let appendpos = 0
    let codestart = 0
    let similarpos = 0
    let similarity = 0
    while line <= line( '$' )
        let s = getline( line )
        if incomment == 1
            let end = matchend( s, '\*/' )
            if end == -1
                let line = line + 1
                continue
            else
                let s = strpart( s, end )
                let incomment = 0
            endif
        endif
        let s = substitute( s, '//.*', '', '' )
        let s = substitute( s, '/\*\([^*]\|\*\@!/\)*\*/', '', 'g' )
        if s =~ '/\*'
            let incomment = 1
        elseif s =~ '^' . include
            break
        elseif s =~ '^#include' && s !~ '\.moc"'
            let appendpos = line
            if s =~ '^#include '.header[0:similarity+1]
                let similarpos = line
                let similarity = similarity + 1
                while s =~ '^#include '.header[0:similarity+1]
                    let similarity = similarity + 1
                endwhile
                if s[9:strlen(s)-2] > header[0:strlen(header)-2]
                    let similarpos = similarpos - 1
                    let similarity = 100 "this include belongs one line higher (assuming the order of includes already is alphabetically)
                endif
            endif
        elseif codestart == 0 && s !~ '^$'
            let codestart = line
        endif
        let line = line + 1
    endwhile
    if similarpos > 0
        let appendpos = similarpos
    endif
    if line == line( '$' ) + 1
        if appendpos == 0
            call append( codestart - 1, include )
            call append( codestart, '' )
        else
            call append( appendpos, include )
        endif
    endif
endfunction

function! AddForward()
    let s = getline( '.' )
    let i = col( '.' ) - 1
    while i > 0 && strpart( s, i, 1 ) !~ '[A-Za-z0-9_:]'
        let i = i - 1
    endwhile
    while i > 0 && strpart( s, i, 1 ) =~ '[A-Za-z0-9_:]'
        let i = i - 1
    endwhile
    let start = match( s, '[A-Za-z0-9_]\+\(::[A-Za-z0-9_]\+\)*', i )
    let end = matchend( s, '[A-Za-z0-9_]\+\(::[A-Za-z0-9_]\+\)*', i )
    if end > col( '.' )
        let end = matchend( s, '[A-Za-z0-9_]\+', i )
    endif
    let ident = strpart( s, start, end - start )
    let forward = 'class ' . ident . ';'

    let line = 1
    let incomment = 0
    let appendpos = 0
    let codestart = 0
    while line <= line( '$' )
        let s = getline( line )
        if incomment == 1
            let end = matchend( s, '\*/' )
            if end == -1
                let line = line + 1
                continue
            else
                let s = strpart( s, end )
                let incomment = 0
            endif
        endif
        let s = substitute( s, '//.*', '', '' )
        let s = substitute( s, '/\*\([^*]\|\*\@!/\)*\*/', '', 'g' )
        if s =~ '/\*'
            let incomment = 1
        elseif s =~ '^' . forward
            break
        elseif s =~ '^\s*class [A-za-z0-9_]\+;' || (s =~ '^#include' && s !~ '\.moc"')
            let appendpos = line
        elseif codestart == 0 && s !~ '^$'
            let codestart = line
        endif
        let line = line + 1
    endwhile
    if line == line( '$' ) + 1
        if appendpos == 0
            call append( codestart - 1, forward )
            call append( codestart, '' )
        else
            call append( appendpos, forward )
        endif
    endif
endfunction

