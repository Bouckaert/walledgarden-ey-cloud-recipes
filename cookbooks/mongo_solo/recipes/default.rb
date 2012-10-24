#
# Cookbook Name:: mongo_solo
# Recipe:: default
#

version = "2.2.0"
file_to_fetch = "http://fastdl.mongodb.org/linux/mongodb-linux-i686-#{version}.tgz"

execute "fetch #{file_to_fetch}" do
  Chef::Log.info "Downloading MongoDB file"
  cwd "/tmp"
  command "wget #{file_to_fetch}"
  not_if { FileTest.exists?("/tmp/mongodb-linux-i686-#{version}.tgz") }
end

execute "untar /tmp/mongodb-linux-i686-#{version}.tgz" do
  Chef::Log.info "Copying mongodb file"
  command "cd /tmp; tar zxf mongodb-linux-i686-#{version}.tgz -C /opt"
  not_if { FileTest.directory?("/opt/mongodb-linux-i686-#{version}") }
end

execute "creating a symbolik link" do
  Chef::Log.info "Creating a symbolic link to mongodump"
  command "ln -s /opt/mongodb-linux-i686-#{version}/bin/mongodump /usr/bin/mongodump"
  not_if { FileTest.exists?("/usr/bin/mongodump") }
end

execute "start mongodb" do
  Chef::Log.info "Executing Mongodb"
  command "sudo /opt/mongodb-linux-i686-#{version}/bin/mongod --journal --fork --logpath /var/log/mongodb.log --logappend"
  Chef::Log.info "Mongodb executed"
end
