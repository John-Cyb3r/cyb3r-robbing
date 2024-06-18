game 'gta5'
fx_version 'cerulean'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Server/main.lua',

}

-- shared_scripts {
--     '@ox_lib/init.lua',
-- }

shared_scripts { 'Config.lua', }

--Client Scripts
client_scripts {
    'Client/main.lua',
}

lua54 'yes'
