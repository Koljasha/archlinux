# автопереход в каталог (функция fish)
#
function rcd --description 'смена каталога в ranger-fm'
    set dir (mktemp -t ranger_cd.XXX)
    ranger --choosedir=$dir
    cd (cat $dir) $argv
    rm $dir
    commandline -f repaint
end

