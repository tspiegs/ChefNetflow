name             'netflow'
maintainer       'tspiegs'
license          'All rights reserved'
description      'Installs/Configures netflow'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

#server side requires aws and ebs, comment that out if you don't wanna EBS back

version          '0.1.7'
depends 'aws'
depends 'ebs'
