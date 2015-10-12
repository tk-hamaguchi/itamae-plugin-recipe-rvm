Given(/^Pending: .+$/) do
  pending
end

Given(/^dockerが稼働している$/) do
  Excon.defaults[:ssl_verify_peer] = false
  Excon.defaults[:write_timeout] = 1000
  Excon.defaults[:read_timeout] = 1000
  run_simple('docker images')
  expect(last_command_started).to have_exit_status(0)
end

Given(/^"([^"]*)"の内容が下記の通りとなっている:$/) do |path, content|
  FileUtils.mkdir_p File.dirname(expand_path(path))
  File.write(expand_path(path), content)
end

Given(/^下記のDockerfileからイメージを作成する:$/) do |dockerfile|
  @image = Docker::Image.build(dockerfile)
end

When(/^作成したイメージに"([^"]*)"をセットアップする$/) do |cookbook|
  cmd = "itamae docker #{cookbook} --no-tls-verify-peer"
  if @image
    cmd += " --image=#{@image.id}"
  else
    fail
  end
  run_simple(cmd, false, 300_000)
  err = stderr_from(cmd)
  fail err if err.length > 0
  image_ids = stdout_from(cmd).match(/INFO : Image created: (\h+)/)
  @image = Docker::Image.new(Docker.connection, { 'id' => image_ids[1] })
end

When(/^セットアップしたDockerイメージに対してserverspecでテストを行う$/) do
  cd('../../') do
    with_environment('BACKEND' => 'docker', 'DOCKER_IMAGE' => @image.id) do
      cmd = 'rspec spec'
      run_simple(cmd, false, 300_000)
      @err = stderr_from(cmd)
    end
  end
end

Then(/^テストが成功している$/) do
  fail @err if @err.length > 0
end
