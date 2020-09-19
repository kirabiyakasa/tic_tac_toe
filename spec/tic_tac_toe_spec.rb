require './main.rb'

describe GameBoard do
  describe '#win_conditions' do
    it "shows victory for player when matching 3 of the 
      same characer (x or o) vertically" do

      spaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      win_conditions = {"147" => "xxx", "258" => "", "369" => ""}

      game = GameBoard.new(spaces, win_conditions)
      player = Player.new("Name1", "Name2")

      expect(check_win_conditions(game, player)).to eql(true)
    end

    it "shows victory for player when matching 3 of the 
      same characer (x or o) horizontally" do

      spaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      win_conditions = {"123" => "", "456" => "ooo", "789" => ""}

      game = GameBoard.new(spaces, win_conditions)
      player1 = double("player name")

      allow(player1).to receive(:keep_score)
      allow(player1).to receive(:name) { "Player Name" }
      allow(player1).to receive(:selection) { "o" }
      allow(player1).to receive(:score) { 0 }

      expect(check_win_conditions(game, player1)).to eql(true)
    end

  end
end