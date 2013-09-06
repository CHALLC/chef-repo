name 'cha_base'
description 'Base role for all CHA servers'

run_list(
  # this adds NRPE support 
  'recipe[nagios::client]',
  # this installs base NRPE checks (see below)
  'recipe[CHA::base_monitoring]'
)

default_attributes(
  :nagios => {
    # you only need this if your nagios server uses a role other than 'monitoring'
    :server_role => 'nagios_server'
  }
)