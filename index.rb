class GameBoard
  attr_accessor :spaces, :win_conditions
  @@board = ""

  def initialize(spaces, win_conditions)
    @spaces = spaces
    @win_conditions = win_conditions
  end

  def update_board(spaces, chosen_space, win_conditions, x_or_o_selection)
    win_conditions.keys.each do |condition|
      if (condition.include?(chosen_space) && 
        win_conditions[condition].include?(x_or_o_selection) == true ||
        condition.include?(chosen_space) && 
        win_conditions[condition].empty?)

        win_conditions[condition] += x_or_o_selection
      end
    end
    show_board(spaces)
  end

  def show_board(spaces)
    @@board =
    " #{x_or_o(spaces[6])} | #{x_or_o(spaces[7])} | #{x_or_o(spaces[8])} \n" +
    "---|---|---\n" +
    " #{x_or_o(spaces[3])} | #{x_or_o(spaces[4])} | #{x_or_o(spaces[5])} \n" +
    "---|---|---\n" +
    " #{x_or_o(spaces[0])} | #{x_or_o(spaces[1])} | #{x_or_o(spaces[2])} "
    puts @@board
  end

  private
  def x_or_o(space)
    if space == "x" || space == "o"
      return space
    else
      return " "
    end
  end

end

class Player
  attr_reader :name, :selection, :score

  def initialize(name, selection)
    @name = name
    @selection = selection
    @score = 0
  end

  def keep_score(player)
    @score += 1
  end

  def reset_score()
    @score = 0
  end

end

def play_again(game, players)
  puts "#{players[0].name}'s score: #{players[0].score}"
  puts "#{players[1].name}'s score: #{players[1].score}"
  puts "Would you like to play another round?\n" +
  "y / n"
  answer = gets.chomp.downcase
  if answer == "y"
    setup_board(players)
  elsif answer == "n"
    puts "Reseting game."
    setup_game()
  else
    puts "Please use 'y' for yes and 'n' for no."
    play_again(game, players)
  end
end

def check_win_conditions(game, player)
  if game.win_conditions.values.any? { |value| value.length == 3 }
    puts "#{player.name} wins!"
    player.keep_score(player)
    return true
  end
end

def play_round(game, players)
  players.each do |player|
    puts "#{player.name}'s turn."
    chosen_space = ""
    until game.spaces.include?(chosen_space = gets.chomp)
      puts "Please select an available space 1-9"
    end
    game.spaces.select do |space|
      if space.include? chosen_space
        space.replace(player.selection)
      end
    end
    game.update_board(game.spaces, chosen_space, game.win_conditions, 
      player.selection)
    if check_win_conditions(game, player) == true
      play_again(game, players)
    end
  end
end

def play_game(game, players)
  while game.win_conditions.values.any? { |value| value.length < 3 }
    play_round(game, players)
  end

end

def setup_board(players)
  spaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  win_conditions = {"123" => "", "456" => "", "789" => "", "147" => "",
  "258" => "", "369" => "", "159" => "", "357" => ""}

  game = GameBoard.new(spaces, win_conditions)
  game.show_board(game.spaces)
  play_game(game, players)
end

def choose_x_or_o(player1_name)
  puts "Choose x or o for #{player1_name}."
  selection = gets.chomp
  if selection.downcase == "o"
    return "o", "x"
  elsif selection.downcase == "x"
    return "x", "o"
  else choose_x_or_o(player1_name)
  end
end

def get_names()
  puts "Who is player 1?"
  player1 = gets.chomp
  puts "Who is player 2?"
  player2 = gets.chomp
  return player1, player2
end

def setup_players()
  player_names = get_names()
  selection = choose_x_or_o(player_names[0])
  player1 = Player.new(player_names[0], selection[0])
  player2 = Player.new(player_names[1], selection[1])
  return player1, player2
end

def setup_game()
  players = setup_players()
  players.each { |player| player.reset_score() }
  board_example =
  " 7 | 8 | 9 \n" + 
  "---|---|---\n" +
  " 4 | 5 | 6 \n" +
  "---|---|---\n" +
  " 1 | 2 | 3 "
  puts board_example
  puts "Use the numpad to select a space as shown above.\n\n"
  setup_board(players)
end
setup_game()
