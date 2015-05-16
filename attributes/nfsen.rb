#nfsen cookbook defaults

default[:netflow][:nfsen][:nfsenuser] = 'www-data'
default[:netflow][:nfsen][:installdir] = '/var/www'

default[:netflow][:nfsen][:sources] = [
  { :sname => "SOURCE", :port => "9995" }
]

default[:netflow][:nfsen][:peer] = nil
default[:netflow][:nfsen][:datadir] = '/data/nfsenflowdata'


#optional EBS volume stuff for NFSEN data
default[:ebs][:volumes]['/data/nfsenflowdata']['size'] = 200 #GBs
default[:ebs][:volumes]['/data/nfsenflowdata']['fstype'] = 'ext4'
default[:ebs][:creds][:databag] = 'aws'
default[:ebs][:creds][:item] = 'main'
