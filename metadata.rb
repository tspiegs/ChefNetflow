name             'netflow'
maintainer       'Amplify'
maintainer_email 'syseng@amplify.com'
license          'All rights reserved'
description      'Installs/Configures netflow'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

#server side requires aws and ebs

version          '0.1.7'
depends 'aws'
depends 'ebs'
