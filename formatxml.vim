function! DoFormatXML() range
    let l:origft = &ft
    set ft=
    exe ":let l:beforeFirstLine=" . a:firstline . "-1"
    if l:beforeFirstLine < 0
        let l:beforeFirstLine=0
    endif
    exe a:lastline . "put ='</PrettyXML>'"
    exe l:beforeFirstLine . "put ='<PrettyXML>'"
    exe ":let l:newLastLine=" . a:lastline . "+2"
    if l:newLastLine > line('$')
        let l:newLastLine=line('$')
    endif
    exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"
    let l:newLastLine=search('</PrettyXML>')
    exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"
    let l:newFirstLine=search('<PrettyXML>')
    let l:newLastLine=search('</PrettyXML>')
    let l:innerFirstLine=l:newFirstLine+1
    let l:innerLastLine=l:newLastLine-1
    exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"
    exe l:newLastLine . "d"
    exe l:newFirstLine . "d"
    exe ":" . l:newFirstLine
    exe "set ft=" . l:origft
endfunction

