name 'nagios_server'
description 'Nagios server'

run_list(
  'recipe[nagios::server]'
)

default_attributes(
  :nagios => {
    :server_auth_method => 'htauth',
    :url => 'http://nagios.chahq.local'
  }
)