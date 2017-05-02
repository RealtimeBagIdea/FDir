**Favorite Directory**
<i>Use for create Shortcut to change Terminal's working directory to your favorite directory</i>

**Installation**
* move ```fdir.sh``` to ```/usr/bin```
* run command ``` sudo chmod 777 /usr/bin/fdir.sh ``` or specific user that you want to wrx such as (775 or 755)
* run command ``` touch ~/.fdirrc ```
* add ``` source ~/.fdirrc ``` to your bashrc or something of your shell
* [Optional] add ``` alias fdir="fdir.sh" ``` to your bashrc or something of your shell. For use fdir instead of fdir.sh
* re-open terminal

**Usage**
If you add ```alias fdir="fdir.sh"``` to your .bashrc you can use ```fdir``` instead of ```fdir.sh```. If not, you must use ```fdir.sh``` instead

* Add Favorite Directory
  - ``` cd /path/to/dir ```
  - ``` fdir -s <key> ``` \<key\> is the key that you want to use for the directory
  - ex. ``` fdir -s mydir ``` 
 
* Remove Favarite Directory
  - ``` fdir -r <key> ``` \<key\> is the key that you want to remove
  - ex. ``` fdir -r mydir ```

* List Favarite Directory
  - ``` fdir -l ```

* Show Version
  - ``` fdir -v ```

* Show Help
  - ``` fdir -h ```
  
* To Change Directory to your Favorite Directory
  - ``` fd_<key> ```
  - ex. ``` fd_mydir ```
