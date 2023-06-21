
fx_version "cerulean"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}


ui_page 'html/index.html'

files {
    'html/js.js',
    'html/index.html',
    'html/style.css',

}

shared_scripts {
    'config.lua',
}

client_scripts {
    'client.lua',
    'albedos.lua',
}


server_scripts {

}