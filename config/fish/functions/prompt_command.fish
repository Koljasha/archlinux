# save current directory (it is necessary for tiling managers like i3, qtile)
#
function prompt_command --on-event fish_prompt --description 'save current directory'
    pwd > /tmp/whereami
end

