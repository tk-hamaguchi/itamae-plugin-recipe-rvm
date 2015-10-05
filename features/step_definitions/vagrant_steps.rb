Given(/^vagrantが使用できる$/) do
  run_simple('vagrant -v')
  expect(last_command_started).to have_exit_status(0)
end

Given(/^下記のVagrantfileからvagrant upする:$/) do |config|
  write_file('Vagrantfile', config)

  cmd = 'vagrant up'
  run_simple(cmd, false, 300_000)

  err = stderr_from(cmd)
  fail err if err.length > 0

  created = stdout_from(cmd).match(/^Bringing machine '(.+)' up with '(.+)' provider...$/)
  @vmname = created[1]
end


When(/^作成した仮想マシンに"([^"]*)"をセットアップする$/) do |cookbook|
  cmd = "itamae ssh --vagrant --host #{@vmname} #{cookbook}"
  run_simple(cmd, false, 300_000)
  err = stderr_from(cmd)
  fail err if err.length > 0
end

When(/^セットアップした仮想マシンに対してserverspecでテストを行う$/) do
  cd('../../') do
    with_environment('BACKEND' => 'vagrant', 'TARGET_HOST' => @vmname) do
      cmd = 'rspec spec'
      run_simple(cmd, false, 300_000)
      @err = stderr_from(cmd)
    end
  end
end

