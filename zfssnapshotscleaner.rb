begin
  `zfs list -t snapshot`.split(/\n/).drop(1).each do |snapshot|
    name = snapshot.split(/ /)[0]
    year, mon, day, hour = name.split(/@/)[1].split(/-/)
    puts "#{year} #{mon} #{day} #{hour}"
    if (day != Time.new.day.to_s && day.to_i != (Time.new.day.to_i - 1)) && (hour != '00')
      puts Time.new.day
      puts "Deleting #{year} #{mon} #{day} #{hour}"
      %x[zfs destroy #{name}]
    end
  end
end
