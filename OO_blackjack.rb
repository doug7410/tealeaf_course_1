
# here is a test for github

# CARDS///////////////////////////////////////////////////////////////
class Card
  attr_accessor :value, :suit, :formated_value, :formated_suit

  def initialize(v,s)
    @value = v
    @suit = s
    @formated_value = "|#{pretty_value(@value)} | "
    @formated_suit = "| #{pretty_suit(@suit)} | "
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


# HAND////////////////////////////////////////////////////////////////
module Hand

  def show_cards
    top_of_card = ''
    card_value = ''
    card_suit = ''
    bottom_of_card = ''
    self.hand.each { top_of_card += "----- " }
    self.hand.each { bottom_of_card += "----- " }
    self.hand.each { |card| card_value += card.formated_value } 
    self.hand.each { |card| card_suit += card.formated_suit }  
    puts top_of_card
    puts card_value
    puts card_suit
    puts bottom_of_card
  end

  def show_dealer_flop
    top_of_card = "----- -----" 
    bottom_of_card = "----- -----" 
    card_value = self.hand[0].formated_value + "|***|" 
    card_suit = self.hand[0].formated_suit  + "|***|"
    puts top_of_card
    puts card_value
    puts card_suit
    puts bottom_of_card
  end

  def calc_cards
    @total = 0
    self.hand.each do |card|
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
  attr_accessor :name, :hand, :chips, :bet

  include Hand

  def initialize
    @name = ''
    @hand = []
    @chips = 500
    @bet = ''
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

  attr_accessor :deck, :player, :dealer, :game_count

  BLACKJACK_AMOUNT = 21
  DEALER_STAY_AMMOUNT = 17

  def initialize 
    @player = Player.new
    @dealer = Dealer.new
    @game_count = 0
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
      display_cards
      break if check_result(@action)
      @action = player.player_action
    end
  end

  def dealer_turn
    display_cards(true)

    #check for Blackjack
    if dealer.calc_cards == BLACKJACK_AMOUNT
      "Sorry, the dealer has Blackjack"
    end
    
    while dealer.calc_cards < DEALER_STAY_AMMOUNT and !player_bust
      sleep 0.5
      dealer.hand.push( deck.deal_card )
      display_cards(true)
    end
    
    check_result(@action)
  end

  def player_bust
    if player.calc_cards > BLACKJACK_AMOUNT
      true
    end
  end

  def check_result(action = false)
    player_total = player.calc_cards
    dealer_total = dealer.calc_cards
    
    if player.hand.count == 2 and player_total == BLACKJACK_AMOUNT
      display_cards(true)
      puts "You have Blackjack! You win #{player.bet.to_i * 2} chips!"
      add_chips
      return 'blackjack'
    elsif player_total > BLACKJACK_AMOUNT
      display_cards(true)
      puts "Sorry, you bust. Better luck next time"
      true
    elsif player_total == BLACKJACK_AMOUNT
      display_cards(true)
      puts "You win #{player.bet.to_i * 2} chips!"
      add_chips
      true
    elsif player_total >  dealer_total and @action == 's'
      puts "You beat the dealer. You win #{player.bet.to_i * 2} chips!"
      add_chips
      true
    elsif dealer_total > BLACKJACK_AMOUNT and @action == 's'
      puts "The dealer bust. You win #{player.bet.to_i * 2} chips!"
      add_chips
      true
    elsif dealer_total > player_total and @action == 's'
      puts "Sorry, the dealer wins this one, better luck next time."
      true
    elsif dealer_total == player_total and @action == 's'
      puts "It's a push."
      true
    end
  end

  def add_chips
    winnings = player.bet.to_i * 2
    player.chips += winnings 
    puts "You now have #{player.chips} chips"
  end

  def deduct_chips
     player.chips -= (player.bet.to_i)
  end

  def check_bet
    while player.bet.to_i == 0 || player.bet.to_i > player.chips
      puts "Please enter a number #{player.chips} or less."
      player.bet = gets.chomp.to_i
    end   
  end

  def shuffle_deck
    if self.game_count > 0
      system 'clear'
      puts 'shuffling the cards'
      sleep 0.7
    end
      @deck = Deck.new(4)
  end

  def greet_player
    system 'clear'
    if self.game_count == 0
      puts "\n---Hi, Welcome to Blackjack! What's your name?---\n\n"
      player.name = gets.chomp
      puts "\nNice to meet you #{player.name}. You have #{player.chips} chips.\n\n"
      puts "How much would you like to bet?"
      player.bet = gets.chomp
      check_bet
      deduct_chips
    else
      if player.chips > 0
        puts "\n---You have #{player.chips} chips, how much would you like to bet?---\n\n"
      else
        puts "\n---You have no more chips! Go home.---"
        exit
      end
      player.bet = gets.chomp
      check_bet
      deduct_chips
    end
  end


  def display_cards(player_stand = false)
    
    system "clear"
    if game_count == 0
      puts "Hi #{player.name}!\n\n"
      puts "Let's get started! \n\n"
    else
      puts "Welcome back #{player.name}"
      puts "We're on round number #{game_count + 1}"
    end
    puts "Rules: (1)Dealer hits under 17 (2)If the round is a push, the dealer wins \n\n"
    draw_line
    puts "Dealer's Cards:\n" 

    if !player_stand
      puts "#{dealer.show_dealer_flop}\n"
    else
      dealer.show_cards
      puts "for a total of #{dealer.calc_cards}\n"
    end
    
    draw_line
    puts "#{player.name}'s cards,  chips: #{player.chips}, current bet #{player.bet}\n\n" 
    player.show_cards
    
    puts "\nfor a total of #{player.calc_cards}\n\n"
    draw_line
  end

  def draw_line
    puts "-------------------------------------\n\n"
  end

  def deal_cards
    player.hand = []
    player.hand.push( deck.deal_card )
    player.hand.push( deck.deal_card )
    dealer.hand = []
    dealer.hand.push( deck.deal_card )
    dealer.hand.push( deck.deal_card )
  end

  def play_again?
    if player.chips == 0
      puts "\n\n--- You have no more chips! Come back when you get paid again. :) ---\n\n"
      exit
    end
      puts "\n\nWould you like to play again #{self.player.name}? y for yes, n for no"
      play_again = gets.chomp
      
      while !['y', 'n'].include?(play_again)
        puts "\n\nSorry I didn't get that. Plase enter y for yes or n for no."
        play_again = gets.chomp
      end

      self.start if play_again == 'y'
  end

  def start
    shuffle_deck      
    greet_player
    deal_cards
    display_cards
    player_turn
    dealer_turn
    self.game_count += 1
    play_again?
  end 
end

game = Blackjack.new
game.start

