
# here is a test for github

# CARDS///////////////////////////////////////////////////////////////
class Card
  attr_accessor :value, :suit, :nice_card

  def initialize(v,s)
    @value = v
    @suit = s
    @nice_card = "
    -----
    |#{pretty_value(@value)} | 
    | #{pretty_suit(@suit)} |
    -----"
  end

  def pretty_suit(suit)
    case suit
      when 'H' then "\u2665"
      when 'D' then "\u2666"
      when 'S' then "\u2660"
      when 'C' then "\u2663"  
    end
  end

  def pretty_value(value)
    if value != 10
      " #{value}"
    else
      "10"
    end
  end

end

# DECK////////////////////////////////////////////////////////////////
class Deck
  attr_accessor :cards

  def initialize(num_of_decks)
    @cards = []
    ['H', 'S', 'C', 'D'].each do |suit|
      [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].each do |value|
        @cards << Card.new(value, suit)
      end
    end
    @cards *= num_of_decks
    scramble!
  end

  def scramble!
    cards.shuffle!
  end 

  def deal_card
    cards.pop
  end
end

# TABLE///////////////////////////////////////////////////////////////
class Table
  
  attr_accessor :player, :dealer

  def initialize(p, d)
    @player = p
    @dealer = d
  end

  def display_cards(player_stand = false)
    system "clear"
    puts "Hi #{player.name}!"
    puts "Rules: (1) Dealer hits under 17 (2)We are playing with four decks \n\n"
    puts "Let's get started! \n\n" 
    puts "-------------------------------------"
    puts "Dealer Cards:\n" 
    
    if !player_stand
      puts dealer.hand[0].nice_card 
      puts "
    -----
    |***|
    |***|
    -----"
    else
      display = ''
      dealer.hand.each do |card|
        display += card.nice_card 
      end
      puts display
      puts "\nfor a total of #{dealer.calc_cards(dealer.hand)}\n"
    end
    
    puts "-------------------------------------\n"
    puts "#{player.name}'s Cards:\n" 
    
    display = ''
    player.hand.each do |card|
      display += card.nice_card  
    end
    puts display
    
    puts "for a total of #{player.calc_cards(player.hand)}\n\n"
    puts "-------------------------------------\n\n"
  end
end


# HAND////////////////////////////////////////////////////////////////
module Hand

  def calc_cards(hand)
    @total = 0
    hand.each do |card|
      if card.value.to_i > 0 # if the card is a number
        @total += card.value
      elsif ["J", "Q", "K"].include?(card.value) #if the card is J, Q, or K
        @total += 10
      elsif card.value == "A" && @total > 10
        @total += 1
      elsif card.value == "A" && @total <= 10  
        @total += 11
      end
    end
    return @total
  end

end


# PLAYER//////////////////////////////////////////////////////////////
class Player
  attr_accessor :name, :hand

  include Hand

  def initialize
    @name = ''
    @hand = []
  end

  def player_action
    puts "Would you like to Hit or Stay? enter h or s"
    @action = gets.chomp
  end

  def stand
    false
  end
end

# DEALER//////////////////////////////////////////////////////////////
class Dealer
  attr_accessor :hand

  include Hand

  def initialize
    @hand = []
  end
end

# BLACKJACK GAME/////////////////////////////////////////////////////
class Blackjack

  attr_accessor :deck, :player, :dealer, :table, :game_count

  def initialize 
    @player = Player.new
    @dealer = Dealer.new
    @table = Table.new(player,dealer)
    @game_count = 0
  end

  def start_game

    if game_count > 0
      system 'clear'
      puts 're-shuffling the cards'
      sleep 1
    end

    @deck = Deck.new(4)
    system 'clear'
    if self.game_count == 0
      puts "Hi, what's your name?"
      player.name = gets.chomp
    end
    player.hand = []
    player.hand.push( deck.deal_card )
    player.hand.push( deck.deal_card )
    dealer.hand = []
    dealer.hand.push( deck.deal_card )
    dealer.hand.push( deck.deal_card )
    table.display_cards
    player_turn
  end

  def player_turn

    @action = ''
    
    #check for Blackjack
    if check_result == 'blackjack'
      @blackjack = true
    else
      #ask to hit or Stay
      @action = player.player_action

      while !['h', 's'].include?(@action)
        puts "Sorry I didn't get that. Plase enter h for hit or s for stay."
        @action = gets.chomp
      end
    end
    
    while @action == 'h' and !@blackjack
      player.hand.push( deck.deal_card )
      sleep 0.5
      table.display_cards
      break if check_result(@action)
      @action = player.player_action
    end
    
    if @action == 's'
      #check for Blackjack
      if player.calc_cards(player.hand) == 21
        "dealer has Blackjack"
      end
      dealer_turn
    end
    
  end

  def dealer_turn
    table.display_cards(true)
    
    while dealer.calc_cards(dealer.hand) < 17
      sleep 0.5
      dealer.hand.push( deck.deal_card )
      table.display_cards(true)
    end
    
    check_result(@action)
  end

  def check_result(action = false)
    @player_total = player.calc_cards(player.hand)
    @dealer_total = dealer.calc_cards(dealer.hand)
    
    if player.hand.count == 2 and @player_total == 21
      table.display_cards(true)
      puts "You have Blackjack!"
      return 'blackjack'
    elsif @player_total > 21
      table.display_cards(true)
      puts "Sorry, you bust. Better luck next time"
      true
    elsif @player_total == 21
      table.display_cards(true)
      puts "You win with 21!"
      true
    elsif @player_total >  @dealer_total and @action == 's'
      puts "You beat the dealer. You win!"
      true
    elsif @dealer_total > 21 and @action == 's'
      puts "The dealer bust. You win!"
      true
    elsif @dealer_total > @player_total and @action == 's'
      puts "Sorry, the dealer wins this one, better luck next time."
      true
    elsif @dealer_total == @player_total and @action == 's'
      puts "It's a push."
      true
    end

  end 
end

game = Blackjack.new

begin
  game.start_game
  game.game_count += 1
  puts "\n\nWould you like to play again #{game.player.name}? y for yes, n for no"
  play_again = gets.chomp
  while !['y', 'n'].include?(play_again)
    puts "\n\nSorry I didn't get that. Plase enter y for yes or n for no."
    play_again = gets.chomp
  end
end while play_again == 'y'
