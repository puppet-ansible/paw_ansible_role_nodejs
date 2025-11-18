# Example usage of paw_ansible_role_nodejs

# Simple include with default parameters
include paw_ansible_role_nodejs

# Or with custom parameters:
# class { 'paw_ansible_role_nodejs':
#   npm_config_prefix => '/usr/local/lib/npm',
#   nodejs_version => '16.x',
#   npm_config_unsafe_perm => 'false',
#   nodejs_npm_global_packages => [],
#   nodejs_package_json_path => undef,
#   nodejs_generate_etc_profile => 'true',
# }
