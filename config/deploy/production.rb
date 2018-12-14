server '52.193.68.209', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/wsl/.ssh/id_rsa'
