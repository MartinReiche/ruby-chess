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
    def save(path)
      f_name = get_filename
      File.open("#{path}/save/#{f_name}.save", 'w') {|f| f.write(Marshal.dump(self)) }
      print "\e[A\e[K   File Saved!\n"
      sleep(0.5)
    end
    def load(path)
      f_name = lookup_filename(path)
      if f_name == false
        print "\e[A\e[K   Invalid Index!\n"
        sleep(1)
        return false
      else
        savefile = Marshal.load(File.read("#{path}/save/#{f_name}"))
        @b = savefile.b
        @p = savefile.p
        @a = savefile.a
        @c = savefile.c
        @m = savefile.m
        print "\e[A\e[K   Game loaded!\n"
        sleep(0.5)
        return true
      end
    end
    private
    def get_filename
      clear_screen(15)
      print "\n\n\n   Saving the current game\n"
      print "\n" * 10
      print "\n" + ("\e[A\e[K") + ("   Enter filename >> ")
      option = gets.chomp
    end
    def lookup_filename(path)
      clear_screen(15)
      files = Dir.entries("#{path}/save/")
      saves = []
      saves = files.select{ |i| i[/\.save$/] }
      print "\n   Choose a file.\n"
      # 10 breaks
      print "\n"
      saves.each_with_index do |f,i|
        print "   #{(i+1).to_s}:    #{f}\n"
      end
      print "\n" * (10-saves.length) if saves.length < 11
      print ("\n\n") + ("\e[A\e[K") + ("   Enter number >> ")
      option = gets.chomp.to_i
      if (1..saves.length).include?(option)
        ret = saves[option-1]
      else
        ret = false
      end
      clear_screen(saves.length-10) if saves.length > 10
      return ret
    end
  end
end


