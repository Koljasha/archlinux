#  equivalent bash PROMPT_COMMAND
#
function prompt_command --on-event fish_prompt --description 'equivalent bash PROMPT_COMMAND'
    pwd > /tmp/whereami
end

