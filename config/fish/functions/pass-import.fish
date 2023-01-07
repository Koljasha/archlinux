# import pass passwords
#
function pass-import --description 'import pass passwords'
	if test -f pass.tar.gz.gpg
		gpg --decrypt pass.tar.gz.gpg > pass.tar.gz
		tar xzvf pass.tar.gz
		rm -rfv ~/.password-store/
		mv -v .password-store/ ~/
		rm -rfv pass.tar.*
		echo "Passwords imported"
	else
		echo "No import file"
	end
end
