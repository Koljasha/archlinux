# python virtualenv
#
function venv --description 'create/activate python virtual environment'
    if test -e .venv
        source .venv/bin/activate.fish
    else
        python -m venv .venv; source .venv/bin/activate.fish
        pip install --upgrade pip
    end
end

