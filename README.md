# Automatic set the correct DNS on WSL startup when using eduroam

DNS resolution times out on WSL2 Windows 10 when connected to eduroam. To fix it you can manually change the internal WSL DNS (/etc/resolv.conf) to match the current DNS from ipconfig. This is simply a script that automates that process plus some more.

## What it does
It checks if you are connected to eduroam, Cisco AnyConnect or neither. It then sets the correct DNS for the given situation. 

## Recommended usage
- Put the script somewhere
- Add it to your .bashrc to run it at startup (The script does nothing if it is not on WSL, so it is safe to add to a general .bashrc)  
  Add to .bashrc:
  ```
  /path/to/repository/wsl-automatic-dns.sh
  ```
- Optionally, edit sudoers so you don't need to type your password everytime:  
  In WSL type:
  ```
  sudo visudo
  ```
  Add to the end of the file:
  ```
  %sudo ALL=(ALL:ALL) NOPASSWD: /usr/bin/dd status=none of=/etc/resolv.conf, /usr/bin/chattr -i /etc/resolv.conf, /usr/bin/chattr +i /etc/resolv.conf
  ``` 

After these steps, the script should automatically run on startup without having to type your sudo password.
