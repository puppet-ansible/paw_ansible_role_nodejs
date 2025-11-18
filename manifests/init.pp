# paw_ansible_role_nodejs
# @summary Manage paw_ansible_role_nodejs configuration
#
# @param npm_config_prefix The directory for global installations.
# @param nodejs_version Version numbers from Nodesource: https://github.com/nodesource/distributions
# @param npm_config_unsafe_perm set explicitly to false, then installing as a non-root user will fail.
# @param nodejs_npm_global_packages Define a list of global packages to be installed with NPM.
# @param nodejs_package_json_path The path of a package.json file used to install packages globally.
# @param nodejs_generate_etc_profile Set to false if you need to handle this manually with a per-user install.
# @param par_tags An array of Ansible tags to execute (optional)
# @param par_skip_tags An array of Ansible tags to skip (optional)
# @param par_start_at_task The name of the task to start execution at (optional)
# @param par_limit Limit playbook execution to specific hosts (optional)
# @param par_verbose Enable verbose output from Ansible (optional)
# @param par_check_mode Run Ansible in check mode (dry-run) (optional)
# @param par_timeout Timeout in seconds for playbook execution (optional)
# @param par_user Remote user to use for Ansible connections (optional)
# @param par_env_vars Additional environment variables for ansible-playbook execution (optional)
# @param par_logoutput Control whether playbook output is displayed in Puppet logs (optional)
# @param par_exclusive Serialize playbook execution using a lock file (optional)
class paw_ansible_role_nodejs (
  String $npm_config_prefix = '/usr/local/lib/npm',
  String $nodejs_version = '16.x',
  String $npm_config_unsafe_perm = 'false',
  Array $nodejs_npm_global_packages = [],
  Optional[String] $nodejs_package_json_path = undef,
  String $nodejs_generate_etc_profile = 'true',
  Optional[Array[String]] $par_tags = undef,
  Optional[Array[String]] $par_skip_tags = undef,
  Optional[String] $par_start_at_task = undef,
  Optional[String] $par_limit = undef,
  Optional[Boolean] $par_verbose = undef,
  Optional[Boolean] $par_check_mode = undef,
  Optional[Integer] $par_timeout = undef,
  Optional[String] $par_user = undef,
  Optional[Hash] $par_env_vars = undef,
  Optional[Boolean] $par_logoutput = undef,
  Optional[Boolean] $par_exclusive = undef
) {
# Execute the Ansible role using PAR (Puppet Ansible Runner)
  $vardir = $facts['puppet_vardir'] ? {
    undef   => $settings::vardir ? {
      undef   => '/opt/puppetlabs/puppet/cache',
      default => $settings::vardir,
    },
    default => $facts['puppet_vardir'],
  }
  $playbook_path = "${vardir}/lib/puppet_x/ansible_modules/ansible_role_nodejs/playbook.yml"

  par { 'paw_ansible_role_nodejs-main':
    ensure        => present,
    playbook      => $playbook_path,
    playbook_vars => {
      'npm_config_prefix'           => $npm_config_prefix,
      'nodejs_version'              => $nodejs_version,
      'npm_config_unsafe_perm'      => $npm_config_unsafe_perm,
      'nodejs_npm_global_packages'  => $nodejs_npm_global_packages,
      'nodejs_package_json_path'    => $nodejs_package_json_path,
      'nodejs_generate_etc_profile' => $nodejs_generate_etc_profile,
    },
    tags          => $par_tags,
    skip_tags     => $par_skip_tags,
    start_at_task => $par_start_at_task,
    limit         => $par_limit,
    verbose       => $par_verbose,
    check_mode    => $par_check_mode,
    timeout       => $par_timeout,
    user          => $par_user,
    env_vars      => $par_env_vars,
    logoutput     => $par_logoutput,
    exclusive     => $par_exclusive,
  }
}
