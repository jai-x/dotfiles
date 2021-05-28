# Defined via `source`
function rbserve --wraps='ruby -run -e -httpd . -p 9090' --description 'alias rbserve=ruby -run -e -httpd . -p 9090'
  ruby -run -e -httpd . -p 9090 $argv; 
end
