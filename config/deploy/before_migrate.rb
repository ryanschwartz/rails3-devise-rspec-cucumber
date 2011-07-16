# Drop it in config/deploy/
#
# It's evaluated inside the deploy resource's context.
#
# It assumes Gemfile and Gemfile.lock are present and satisfy Bundler's
# requirements for the --deployment option.

current_release_directory = release_path
running_deploy_user = new_resource.user
bundler_depot = new_resource.shared_path + '/bundle'
excluded_groups = %w(development test)

script 'Bundling the gems' do
  interpreter 'bash'
  cwd current_release_directory
  user running_deploy_user
  code <<-EOS
    bundle install --quiet --deployment --path #{bundler_depot} \
      --without #{excluded_groups.join(' ')}
  EOS
end
