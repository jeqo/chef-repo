include_recipe "tar"

soapui_installer = File.join(Chef::Config[:file_cache_path], 'soapui-bin.tar.gz')

remote_file soapui_installer do
  source node['soapui']['url']
  checksum node['soapui']['checksum']
  action :create
end

tar_extract soapui_installer do
  action :extract_local
  target_dir '/opt/soapui'
  creates '/opt/soapui/bin'
end
