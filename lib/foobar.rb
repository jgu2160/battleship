class Test
	class Fooz
	  def bar
	    puts caller[0]
	  end
	end

  def foo
    fooz = Fooz.new.bar
  end


end



test = Test.new
test.foo