# Call installation of nfs v4
include_recipe "nfs::client4"

# Create a local directory
directory "#{node['nfs-client']['local-directory']}" do
  action :create
end

# Command to map directories
command_mount = "mount -t nfs -o nfsvers=4 #{node['nfs-client']['server-host']}:#{node['nfs-client']['remote-directory']} #{node['nfs-client']['local-directory']}"

# Run command
execute command_mount do
  action :run
end
