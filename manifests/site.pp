#if $osfamily == 'debian'{
#  include chrony
#}

#class { 'motd':
#  template => 'motd/motd.epp',
#  content  => "Hello world\n",
#}

exec { 'my_exec_command':
  command => 'ls -alrt',
  path   =>'/usr/bin:/usr/local/bin',
  cwd  => '/etc/puppetlabs/puppet',
  logoutput => true,
}

$result = []
Exec['my_exec_command']->Notify['results']

notify{'results':
  message => "c'est la directory puppet : ${result}",
}

$result = split(trim($::output),"\n")