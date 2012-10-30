#
# Cookbook Name:: rabbitmq
# Recipe:: default
#

rabbitmq_version = "2.3.1"

ey_cloud_report "RabbitMQ" do
  message "installing RabbitMQ #{rabbitmq_version}"
end

enable_package "net-misc/rabbitmq-server" do
  version rabbitmq_version
end

package "net-misc/rabbitmq-server" do
  version rabbitmq_version
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
