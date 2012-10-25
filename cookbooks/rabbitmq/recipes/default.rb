#
# Cookbook Name:: rabbitmq
# Recipe:: default
#

enable_package "net-misc/rabbitmq-server" do
  version "2.3.1"
end

package "net-misc/rabbitmq-server" do
  version "2.3.1"
  action :install
end

template "/etc/monit.d/rabbitmq.monitrc" do
  source "rabbitmq.monitrc.erb"
  owner node[:owner_name]
  group node[:owner_name]
  mode 0644
end

execute "start RabbitMQ" do
  Chef::Log.info "Starting RabbitMQ"
  command "sudo /etc/init.d/rabbitmq start"
  not_if { FileTest.exists?("/var/run/rabbitmq.pid") }
end
