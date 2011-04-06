"Language: Jape
"@author Nikola Valentinov Petrov
"nikola.petrov@ontotext.com
"
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif
"Read the java syntax so we can get nice syntax highlighting for the classes
"there.

syn include @javaGroup syntax/java.vim

syn keyword BasicAnnotations    Token Lookup Person SpaceToken 
syn match JapeLabels "Rule:"he=e-1
syn match JapeLabels "Macro:"he=e-1
syn match JapeLabels "Phase:"he=e-1
syn match JapeLabels "Input:"he=e-1
syn match JapeLabels "Options:"he=e-1
syn match JapeLabels "Priority:"he=e-1
"Comments
syn keyword todo		 contained TODO FIXME XXX
syn region  comment		 start="/\*"  end="\*/" contains=todo,@Spell
syn match   lineComment      "//.*" contains=javaTodo,@Spell
"TODO: Maybe it will be nice to include the error checking from the java
"version
syn region  string		start=+"+ end=+"+ end=+$+
syn cluster top contains=string,comment,lineComment
"Don't highlight those. Hurts the eyes too much.
syn match Op    "=="
syn match Op    ">"
syn match Op    ">"
syn match Op    ">="
syn match Op    "<" 
syn match Op    "<=" 
syn match Op    "|" 
syn match Arrow             "-->"
syn region  AnnotationRegion    start="{" end="}" contains=BasicAnnotations,Op,@top contained
syn region JapeMacro start="(" end=")" contains=JapeMacro,AnnotationRegion,Op,@top fold
syn region  Block start="{" end="}" contains=Block,@javaGroup fold keepend contained
syn region  JavaCode      start="-->\(\s\|\n\)*{" end="}" contains=Block,Arrow,@javaGroup

hi def link JapeMacro Constant

hi def link string String
hi def link comment Comment
hi def link lineComment Comment
hi def link JapeLabels Label
hi def link BasicAnnotations Structure
hi def link Arrow        Operator
hi def link AnnotationRegion Function

let b:current_syntax = "jape"
