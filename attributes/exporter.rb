#Default attributes for exporter portion of nfsen (netflow)
#netflow_server = search(:node, "role:nfsen AND chef_environment:#{node.environment}") || nil
#if netflow_server.size != 1 , log.error "more than 1 netflow_server found" else, netflow_server_ip = netflow_server.first.ipaddress
default['netflow']['exporter']['toIP'] = '127.0.0.1'
default['netflow']['exporter']['toport'] = '9995'
default['netflow']['exporter']['interface'] = 'any'
