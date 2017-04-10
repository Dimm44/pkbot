class Object
  def no_ex(msg = nil)
    begin
      yield
    rescue Exception => e
      puts "FAIL: #{msg || e.to_s}"
      puts e.to_s if msg
      puts e.backtrace.join("\n")
    end
  end
end