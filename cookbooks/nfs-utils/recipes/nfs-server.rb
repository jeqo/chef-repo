# Call installation of nfs v4
include_recipe "nfs::server4"

# Create a directory to share
directory node['nfs-server']['shared-directory'] do
  action :create
end

# Export directory
nfs_export node['nfs-server']['shared-directory'] do
  network '*'
  writeable true
  sync true
  options ['insecure']
end
