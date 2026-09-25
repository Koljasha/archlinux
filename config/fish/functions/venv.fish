# виртуальное окружение Python (virtualenv)
#
function venv --description 'создать/активировать виртуальное окружение Python'
    if test -e .venv
        source .venv/bin/activate.fish
    else
        python -m venv .venv; source .venv/bin/activate.fish
        pip install --upgrade pip
    end
end

