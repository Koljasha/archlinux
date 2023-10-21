# import ssh keys and configs
#
function ssh-import --description 'import ssh keys and configs'
	if test -f ssh_keys.tar.gz.gpg
		gpg --decrypt ssh_keys.tar.gz.gpg > ssh_keys.tar.gz
		if test $status -eq 0
			tar xvf ssh_keys.tar.gz
			if test -d ~/.ssh
				rm -rf ~/.ssh/*
			else
				mkdir ~/.ssh
				chmod 700 ~/.ssh
			end
			cp -r ssh_keys/. ~/.ssh/
			rm -rf ssh_keys.tar.* ssh_keys/
			echo "SSH keys imported"
		else
			echo "Invalid decryption"
		end
	else
		echo "No import file"
	end
end
