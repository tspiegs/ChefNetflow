#This recipe will export all netflow data to the nfsen server

package "softflowd" do
  action :install
end

template "/etc/default/softflowd" do
  source "softflowd.erb"
  mode "0644"
  variables({
    :toport => node[:netflow][:exporter][:toport],
    :toIP => node[:netflow][:exporter][:toIP],
    :interface => node[:netflow][:exporter][:interface],
    :maxflows => node[:netflow][:exporter][:maxflows]
    })
end

service "softflowd" do
  action [:enable, :start]
  subscribes :restart, "template[/etc/default/softflowd]"
end
