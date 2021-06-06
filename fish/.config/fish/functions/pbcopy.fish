# Defined via `source`
function pbcopy --wraps='xclip -sel clip' --description 'alias pbcopy=xclip -sel clip'
  xclip -sel clip $argv; 
end
