# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
SERVER = "46.101.228.77"
role :app, [SERVER] 
role :web, [SERVER] 

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server SERVER, user: 'deploy', roles: %w{web app}

set :ssh_options, {
    forward_agent: true
}
