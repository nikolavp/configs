" nopaste.vim - interface to http://rafb.net/paste
" Maintainer:   Nikola Petrov <nikolavp@gmail.com>
" Time-stamp: <05 Aug 2008 22:46 Nikola Petrov >
" License:	This file is placed in the public domain.
" Dependency - +python support
"Exit the script if the plugin was loaded or we are in compitable mode "
"If g:loaded_nopaste is set to 0 we will not continue too"
if (exists("g:loaded_nopaste") && g:loaded_nopaste) || &cp || !has('python')
 finish
endif
"Set the global variables"
let g:loaded_nopaste = 1
let g:nickname = ""
function! Paste(cword)
python <<EOF
def paste():
    import urllib
    import urllib2
    import vim
    ftype = vim.eval("&filetype")
    languageDic = {'cpp': 'C++',
            'c': 'C',
            'cs': 'C#',
            'perl': 'Perl',
            'php': 'PHP',
            'python': 'Python',
            'ruby': 'Ruby',
            'sql': 'SQL',
            'java': 'Java'}
    try:
        language = languageDic[ftype]
    except KeyError:
        #If the filetype is not in the list default to PT
        language = "Plain Text"
    url = "http://rafb.net/paste/paste.php"
    nickname = vim.eval("g:nickname")
    description = vim.eval('expand("%:t")')
    text = vim.eval("a:cword")
    #Replace the file ending from ^M to \n which nopaste understands
    text = text.replace("", "\n")
    if text == "%":
        filename = vim.eval("expand('%:p')")
        text = open(filename).read()
    values = {"lang": language,
              "nick": nickname,
              "desc": description,
              "text": text}
    data = urllib.urlencode(values)
    req = urllib2.Request(url, data)
    response = urllib2.urlopen(req)
    #Set the + and * register to the gotten url , so we can paste it
    setreg1 = "call setreg('*', '%s')" %response.geturl()
    setreg2 = "call setreg('+', '%s')" %response.geturl()
    vim.command(setreg1)
    vim.command(setreg2)
EOF
py paste()
endfunction
command! Paste call Paste("%")
