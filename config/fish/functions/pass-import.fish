# import pass passwords
#
function pass-import --description 'import pass passwords'
	if test -f pass.tar.gz.gpg
		gpg --decrypt pass.tar.gz.gpg > pass.tar.gz
		if test $status -eq 0
			tar xzvf pass.tar.gz
			rm -rfv ~/.password-store/
			mv -v .password-store/ ~/
			rm -rfv pass.tar.*
			echo "Passwords imported"
		else
			echo "Invalid decryption"
		end
	else
		echo "No import file"
	end
end
