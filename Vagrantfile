# Load Vagrantfile.setup#
# references
# https://gist.github.com/mkubenka/33b542cbd82614fe7f8b
# user_data for windows winrm
# https://github.com/erran-r7/multiple_vagrantfiles
# winrm
# http://www.hurryupandwait.io/blog/understanding-and-troubleshooting-winrm-connection-and-authentication-a-thrill-seekers-guide-to-adventure
# great bootstrap script
# https://gist.githubusercontent.com/masterzen/6714787/raw
# http://www.masterzen.fr/2014/01/11/bootstrapping-windows-servers-with-puppet/
load File.expand_path('../Vagrantfile.setup', __FILE__)

Vagrant.configure(2) do |config|
  config.vm.box = "dummy"
  config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
  config.vm.communicator = "winrm"
  # config for vagrant-aws-winrm plugin
  config.winrm.username = $windows_username
  config.winrm.transport = :plaintext
  config.winrm.basic_auth_only = true
  config.vm.guest = :windows
  # setup each machine.
  $ec2_instances.each do |ec2_instance|
    config.vm.define ec2_instance do |config2|

      # custom config block for AWS provider.
      config2.vm.provider :aws do |ec2, override|
        # config for vagrant-aws-winrm plugin
        override.winrm.password = "VagrantRocks"

        # issue #5: synced folders do not appear to work
        override.vm.synced_folder ".", "/vagrant", disabled: true

        ec2.keypair_name = $keypair_name
        ec2.access_key_id = $access_key_id
        ec2.secret_access_key = $secret_access_key
        ec2.security_groups = $security_groups
        ec2.region = $aws_region
        ec2.availability_zone = $aws_zone
        ec2.ami = $aws_ami
        ec2.instance_type = $aws_instance_type
        ec2.elastic_ip = $aws_elastic_ip
        ec2.tags = {
          'Name'         => "#{ec2_instance}"
        }
      end
    end
  end

  ###################
  # PROVISIONING
  ###################


  # sync current directory to remote server
  $cmd = "powershell -executionpolicy unrestricted \
    ./scripts/rsync.ps1 -localPath #{Dir.pwd} \
    -remoteServer #{$aws_elastic_ip} \
    -remotePath C:/Users/Administrator/biztalk-provisioner \
    -username Administrator -password VagrantRocks"
  config.vm.provision :host_shell do |host_shell|
      host_shell.inline = $cmd
  end

  # provision with puppet
  config.vm.provision :puppet do |puppet|
    # remote manifest path
    puppet.manifests_path = ["vm", "C:/Users/Administrator/biztalk-provisioner/manifests"]
    # remote module Path: https://github.com/mitchellh/vagrant/issues/2902
    puppet.options = ["--modulepath C:/Users/Administrator/biztalk-provisioner/modules"]
    puppet.manifest_file = "default.pp"
    puppet.binary_path = "C:/puppet/bin"
  end

  # TODO
  # automate installation of modules
  # https://forge.puppet.com/puppetlabs/powershell
  # https://forge.puppet.com/puppet/download_file/


end
