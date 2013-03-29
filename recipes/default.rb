#p node['userhomedir']
dir = "#{node['ssh_keys']['userhomedir']}/.ssh"

directory dir do
  owner node['ssh_keys']['username']
  group node['ssh_keys']['usergroup']
  action :create
end

p node['ssh_keys']
p dir
node['ssh_keys'].each do |k, v|
  next unless k.match(/^id_/)
  p k
  
  file "#{dir}/#{k}" do
    owner node['ssh_keys']['username']
    group node['ssh_keys']['usergroup']
    mode k.match(/\.pub$/) ? "644" : "600"
    content v
  end
end
