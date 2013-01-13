runtime! ftplugin/text.vim ftplugin/text_*.vim ftplugin/text/*.vim

iab <buffer> sjava {code:language=java}{code}<left><left><left><left><left><left><CR><CR><UP><C-R>=Eatchar('\s')<CR>
iab <buffer> sxml {code:language=xml}{code}<left><left><left><left><left><left><CR><CR><UP><C-R>=Eatchar('\s')<CR>
iab <buffer> sbash {code:language=bash}{code}<left><left><left><left><left><left><CR><CR><UP><C-R>=Eatchar('\s')<CR>
