#
# MySQL orchestrator: For managing replication and failover.
#
class orchestrator (
  String $config          = $orchestrator::params::config,
  Hash $config_defaults   = $orchestrator::params::config_defaults,
  Hash $config_override   = {},
  String $config_template = $orchestrator::params::config_template,
  String $package_ensure  = $orchestrator::params::package_ensure,
  Boolean $package_manage = $orchestrator::params::package_manage,
  Array $package_name     = $orchestrator::params::package_name,
  Boolean $repo_manage    = $orchestrator::params::repo_manage,
  Boolean $service_enable = $orchestrator::params::service_enable,
  String $service_ensure  = $orchestrator::params::service_ensure,
  Boolean $service_manage = $orchestrator::params::service_manage,
  String $service_name    = $orchestrator::params::service_name,
  String $user            = $orchestrator::params::user,
  String $group           = $orchestrator::params::group
) inherits orchestrator::params {


  # Using anchor pattern based on known issue:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'orchestrator::begin': } ->
  class { '::orchestrator::repo': } ->
  class { '::orchestrator::install': } ->
  class { '::orchestrator::config': } ~>
  class { '::orchestrator::my_cnf': } ~>
  class { '::orchestrator::service': } ->
  anchor { 'orchestrator::end': }

}
