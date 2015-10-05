# language: ja

機能: Recipe rvm::system

背景:
  * "cookbooks/rvm/system.rb"の内容が下記の通りとなっている:
    """
    package 'sudo'
    include_recipe 'rvm::system'
    """

シナリオ: Dockerへのインストール
  前提 dockerが稼働している
  かつ 下記のDockerfileからイメージを作成する:
    """
    #
    # https://hub.docker.com/_/centos/#dockerfile-for-systemd-base-image
    #
    FROM centos:7
    MAINTAINER "you" <your@email.here>
    ENV container docker
    RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
    RUN yum -y update; yum clean all; \
    (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;
    VOLUME [ "/sys/fs/cgroup" ]
    CMD ["/usr/sbin/init"]
    """
  もし 作成したイメージに"cookbooks/rvm/system.rb"をセットアップする
  かつ セットアップしたDockerイメージに対してserverspecでテストを行う
  ならば テストが成功している

シナリオ: Vagrantへのインストール
  前提 vagrantが使用できる
  かつ 下記のVagrantfileからvagrant upする:
    """
    Vagrant.configure(2) do |config|
    config.vm.box = "centos7"
      config.vm.box_url = "https://f0fff3908f081cb6461b407be80daf97f07ac418.googledrive.com/host/0BwtuV7VyVTSkUG1PM3pCeDJ4dVE/centos7.box"
      config.vm.network "private_network", ip: '192.168.33.101'
      config.ssh.forward_agent = true
    end
    """
  もし 作成した仮想マシンに"cookbooks/rvm/system.rb"をセットアップする
  かつ セットアップした仮想マシンに対してserverspecでテストを行う
  ならば テストが成功している
