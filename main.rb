require_relative 'lib/app'

class Menu
  def initialize
    @app = App.new
    @options = {
      1 => :list_all_books,
      2 => [:list_all_music_albums, @app.music_albums],
      3 => :list_of_games,
      4 => [:list_all_genres, @app.genres],
      5 => :list_all_labels,
      6 => :list_all_authors,
      7 => :add_book,
      8 => [:add_music_album, @app.music_albums],
      9 => :add_game,
      10 => :exit_program
    }
  end

  def main
    menu
  end

  private

  def menu
    puts ' Welcome to MY Catalog of Things! '.center(50, '#'), "\n"

    loop do
      main_menu
      print 'Choice: '
      choice = gets.chomp.to_i
      user_choice(choice)
    end
  end

  def main_menu
    @options.each { |num, option| puts "#{num} - #{option_to_text(option)}" }
  end

  def user_choice(choice)
    selected_option = @options[choice]
    return exit_program if selected_option.nil?

    method_name, data_array = selected_option
    @app.send(method_name, data_array)
  end

  def option_to_text(option)
    option.to_s.tr('_', ' ').split.map(&:capitalize).join(' ')
  end
end

menu = Menu.new
menu.main
