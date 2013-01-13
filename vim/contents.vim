"content creation - some of this is taken from
if has("autocmd")
    augroup content
        autocmd!
        autocmd BufNewFile *.rb 0put ='# vim: set sw=4 sts=4 et tw=80 :' |
                    \ 0put ='#!/usr/bin/ruby' | set sw=4 sts=4 et tw=80 |
                    \ norm G
        autocmd BufNewFile *.hh 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
                    \ 1put ='/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */' |
                    \ 2put ='' | call IncludeGuard() |
                    \ set sw=4 sts=4 et tw=80 | norm G
        autocmd BufNewFile *cpp 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
                    \ 1put ='/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */' |
                    \ 2put ='' | 3put ='' | call setline(3, '#include "' .
                    \ substitute(expand("%:t"), ".cc$", ".hh", "") . '"') |
                    \ set sw=4 sts=4 et tw=80 | norm G
        autocmd BufNewFile *.sh 0put ='#!/bin/bash' |
                    \ 1put ='# vim: set sw=4 sts=4 et foldmethod=indent :' |
                    \ set sw=4 sts=4 et tw=80 |
                    \ norm G
        autocmd BufNewFile *.py 0put ='# vim: set sw=4 sts=4 et foldmethod=indent :'|
                    \ 0put ='#!/usr/bin/env python' |
                    \ set sw=4 sts=4 et tw=80 |
                    \ norm G
    augroup END
endif
