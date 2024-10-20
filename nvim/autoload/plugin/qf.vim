" prevent errors from requiring an additional key to continue
function plugin#qf#location_list()
  try
    exec "normal \<plug>(qf_loc_toggle)"
  catch 'E776'
    echohl ErrorMsg | echo 'E776: No location list' | echohl None
  endtry
endfunction
