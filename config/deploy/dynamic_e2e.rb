set :stage, :demo
server '205.147.102.66', user: 'root', roles: %w{web app db}

set :deploy_to, '/var/www/apps/dynamic'
