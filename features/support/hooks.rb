After do |scenario|
  if @container
    @container.stop
    @container.delete(force: true)
  end

  if @image && Docker::Image.all.map(&:id).include?(@image.id)
    @image.remove(force: true)
  end

  if @vmname
    run_simple('vagrant status default')
    if stdout_from('vagrant status default') =~ /^default\s+running\s+/
      run_simple('vagrant destroy default -f')
    end
  end
end
