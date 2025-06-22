fx_version('cerulean')
games({ 'gta5' })

files({
    'ui/*.html',
    'ui/*.js',
    'ui/*.css'
})

ui_page({ 'ui/index.html' });

shared_scripts({
    '@es_extended/imports.lua',
    'shared/*.lua'
});

server_scripts({
    'server/*.lua'
});

client_scripts({
    'client/*.lua'
});
