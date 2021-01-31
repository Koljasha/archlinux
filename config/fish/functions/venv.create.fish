# python virtualenv
#
function venv.create --description 'create and activate python virtual environment'
     python -m venv venv; and venv.activate; and pip install wheel
end

