fx_version 'adamant'
game 'gta5'

-----------IMPORTANT------------
client_scripts {
	'@es_extended/locale.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',

}
-----------IMPORTANT------------

----barber

client_scripts {
  'client/*.lua',
  'pmenu.lua'
}

server_script 'serveur/*.lua'