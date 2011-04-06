
let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet jag AnnotationSet ".st."variable1".et." = (AnnotationSet)bindings.get(".st."string".et.");<CR>Annotation ".st."variable2".et." = (Annotation)".st."variable1".et.".iterator.next();"
exec "Snippet imports Imports: {<CR> import static gate.Utils.*<CR>}"
