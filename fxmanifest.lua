name "Cyb3r-Robbing"
author "Cyb3r"
version "v1.0.0"
description "Specific Item/Cash Robbing Script For QBCore Framework"

game 'gta5'
fx_version 'cerulean'

server_scripts {
    'Server/main.lua',
}

shared_scripts { 'Config.lua', }


client_scripts {
    'Client/main.lua',
}

lua54 'yes'
