# import pass passwords
#
function pass-import --description 'import pass passwords'
	if test -f pass.tar.gz.gpg
		gpg --decrypt pass.tar.gz.gpg > pass.tar.gz
		if test $status -eq 0
			tar xvf pass.tar.gz
			if test -d ~/.password-store
				rm -rf ~/.password-store/*
				rm -rf ~/.password-store/.*
			else
				mkdir ~/.password-store
			end
			cp -r passwords/. ~/.password-store/
			rm -rf pass.tar.* passwords/
			echo "Passwords imported"
		else
			echo "Invalid decryption"
		end
	else
		echo "No import file"
	end
end
