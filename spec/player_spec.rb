require_relative "../lib/player"
describe Player do
  describe "#get_random_char" do
    xit "returns a random character" do
      player = Player.new(nil)
      expect(player.get_random_char).to match(%r{[0-9a-zA-Z!@#\$%\^&*\(\)\-\+=\{\}\[\]\|:;<>,\.\?/]})
    end
    xit "returns a random character that is not in the exclude list" do
      player = Player.new(nil)
      expect(player.get_random_char("a")).not_to eq("a")
    end
  end
  describe "#assign_symbol" do
    it "chooses random symbol if no symbol is provided" do
      human = Player.new(nil)
      human.assign_symbol
      expect(human.symbol).not_to be_empty
    end
    xit "assign given symbol" do
      human = Player.new(nil)
      human.assign_symbol("a")
      expect(human.symbol).to eq("a")
    end
    xit "asks for a symbol if the given symbol is in exclude" do
      human = Player.new(nil)
      human.assign_symbol("a", "a")
      expect(human.symbol).not_to eq("a")
    end
  end
end
