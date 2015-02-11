require 'terminfo'
require "pp"
# p TermInfo.screen_size

class Consola

	def get_presentation(file)
	@presentation = Presentation.new(file)
	end

	def next_slide
		@presentation.get_next
		self.show_slide
	end

	def prev_slide
		@presentation.get_prev
		self.show_slide
	end

	def show_slide
		self.show_content
		while true
			input = gets.chomp
			if input == "n" || input == ""
				self.next_slide
				break
			elsif input == "p"
				self.prev_slide
				break
			end
		end
	end

		def start
			self.show_slide			
		end

	def show_content
		consola_size = TermInfo.screen_size
		space_line = (consola_size[0] - 1)/2.0

		print "\n"*space_line.floor
		print @presentation.slide[@presentation.position].center(consola_size[1])
		print "\n"*space_line.ceil

	end
end

class Presentation
	attr_accessor :slide, :n_slide, :position
	def initialize(file)
	@slide = IO.read(file).split("\n----\n")
	@n_slide = @slide.size
	@position = 0
	end

	def get_next
		if @position < @n_slide -1
			@position += 1
		else
			exit
		end
	end

	def get_prev
		if @position > 0
			@position -= 1
		end
	end
end

consola = Consola.new
consola.get_presentation("keynote_text.txt")
consola.start

