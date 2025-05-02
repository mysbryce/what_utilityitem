
fx_version 'cerulean'

game 'gta5'
lua54 'yes'

version '1.0.0'

description 'What Utility Item'


shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
	'modules/**/config/*.lua',
}

client_scripts {
	'modules/**/client/*.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'modules/**/server/*.lua',
}

dependencies {
	'es_extended',
	'ox_lib',
	'mythic_progbar',
}