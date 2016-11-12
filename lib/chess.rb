module Chess
  require_relative './board'
  require_relative './figures'
  require_relative './player'
  require_relative './game'

  class Savegame
    attr_accessor :b, :p, :a, :c, :m
    def initialize
      @b = nil
      @p = nil
      @a = nil
      @c = nil
      @m = nil
    end
    def save
      s = Marshal.dump(self)
      f_name = get_filename
      # File.open(f_name, 'w') {|f| f.write(Marshal.dump(s)) }
    end
    def load
      f_name = lookup_filename
    end
    private
    def get_filename
      clear_screen(15)
      print "\n\n   Saving the current game\n"
      print "\n" *11
      print "\n" + ("\e[A\e[K") + ("   Enter filename >> ")
      option = gets.chomp
    end
    def lookup_filename
      
    end
  end
  
end


