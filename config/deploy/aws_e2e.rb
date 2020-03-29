set :stage, :demo
server '13.232.71.239', user: 'root', roles: %w{web app db}

set :deploy_to, '/var/www/apps/hotelolite'
