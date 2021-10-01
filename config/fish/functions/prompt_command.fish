#  equivalent bash PROMPT_COMMAND
#
function prompt_command --on-event fish_prompt
    pwd > /tmp/whereami
end

