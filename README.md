**Favorite Directory**
<i>Use for create Shortcut to change Terminal's working directory to your favorite directory</i>

| Version | Update Detail                                                                         |
| :------:|:--------------------------------------------------------------------------------------|
|   1.2   | Add Init Flag                                                                         |
|   1.1   | Add User Config                                                                       |


**Installation**
* move ```fdir.sh``` to ```/usr/bin```
* run command ``` sudo chmod 777 /usr/bin/fdir.sh ``` or specific user that you want to wrx such as (775 or 755)
* run command ``` fdir.sh init ```
* [Optional] add ``` alias fdir="fdir.sh" ``` to your bashrc or something of your shell. For use fdir instead of fdir.sh
* re-open terminal

**User Config**
* You can edit something by open fdir.sh file and move to 'USER CONFIG'
  - ``` PREFIX_ ``` = prefix of key. default is 'fd-'
  - ``` FILENAME_ ``` = data file name. default is '.fdirrc'
  - ``` SAVE_FLAG_ ``` = save flag use to save key. default is '-s'
  - ``` REMOVE_FLAG_ ``` = remove flag use to remove key. default is '-r'
  - ``` LIST_FLAG_ ``` = list flag use to list all key. default is '-l'

**Usage**
If you add ```alias fdir="fdir.sh"``` to your .bashrc you can use ```fdir``` instead of ```fdir.sh```. If not, you must use ```fdir.sh``` instead

* Init
  - ``` fdir init ``` to automatic create ``` ~/.fdirrc ``` file and add ```source ~/.fdirrc``` to your shell init (you must input your shell init file. Default is ``` .bashrc ```)
  - ex. ``` fdir -s mydir ``` 

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
  - ``` <prefix><key> ```
  - ex. ``` fd-mydir ```
