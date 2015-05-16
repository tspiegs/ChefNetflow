#netflow collector recipe

#EBS info if using EBS volumes
include_recipe "ebs::volumes" if ( !Dir.exists?(node[:netflow][:nfsen][:datadir]) && !node[:ec2].nil? )


install_dir = node["netflow"]["nfsen"]["installdir"]

%w{apache2 nfdump libapache2-mod-php5 php5-common rrdtool libmailtools-perl librrds-perl libio-socket-ssl-perl}.each do |pkg|
  package pkg do
    action :install
  end 
end

template "/etc/init/nfsen.conf" do
  source "nfsen.erb"
  variables({
    :nfsenuser => node[:netflow][:nfsen][:nfsenuser],
    :sources => node[:netflow][:nfsen][:sources],
    :peer => node[:netflow][:nfsen][:peer],
    :datadir => node[:netflow][:nfsen][:datadir]
    })
  Chef::Log.info("tell me what variable #{node[:netflow][:nfsen][:sources]} is") 
  notifies :restart, "service[nfsen]"
end

%w[ /data /data/nfsen ].each do |path|
  directory path do
    owner 'www-data'
    group 'www-data'
    action :create
  end
end


cookbook_file "#{install_dir}/nfsen.tar.gz" do
  source "nfsen.tar.gz"
end

#manual unzip / symbolic links for nfsen
bash 'install_nfsen' do
  not_if { ::File.exists?("#{install_dir}/nfsen") }
  cwd "#{install_dir}"
  code <<-EOH
          sudo tar xf nfsen.tar.gz
          cd nfsen/
          sudo ./install.pl /etc/init/nfsen.conf 
          ln -s /data/nfsen/bin/nfsen /sbin/nfsen
          ln -s /data/nfsen/bin/nfsen /etc/init.d/nfsen
          ln -s /var/www/nfsen/nfsen.php /var/www/nfsen/index.php 
  EOH
end

service "nfsen" do
  action     :start 
  provider Chef::Provider::Service::Init
  subscribes :restart, "template[/etc/init/nfsen.conf]"
end
