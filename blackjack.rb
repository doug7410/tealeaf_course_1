#blackjack
# GREET THE PLAYER
system "clear"
puts "\n"
puts "Welcome to Blackjack at the Tealeaf casino! \n\n"
puts "What is your name? \n"
player_name = gets.chomp



# BEGIN GAME

def play_round(player_name, returning)

def calc_cards(hand)

total = 0 #start of with 0

  hand.map do |card|
    card_value = card.first
    if card_value.to_i > 0 # if the card is a number
      total += card_value
    elsif card_value == "J" || card_value == "Q" || card_value == "K" #if the card is a jack, queen, or king
      total += 10
    elsif card_value == "A" && total > 10
      total += 1
    elsif card_value == "A" && total <= 10  
      total += 11
    end
  end 
  total
end

def finish_round(dealer,player, dealer_blackjack = false)
  if dealer == 21 && player != 21 && dealer_blackjack
    puts "Sorry! The dealer wins with blackjack!"
  elsif player == 21 && dealer != 21
    puts "Congrats, you have blackjack!"
  elsif dealer > 21
    puts "The dealer bust. You win!"
  elsif player > 21
    puts "You bust. Sorry, the dealer wins this one."
  elsif dealer > player
    puts "Sorry! The dealer wins this round."
  elsif dealer < player
    puts "Congrats! You win this round."
  elsif dealer == player
    puts "It looks like we have a tie"
  
  end
end

def display_cards(dealer_hand, player_hand, dealer_total, player_total, player_name, returning, show_dealer_cards = false)
  system "clear"
  if !returning
    puts "Nice to meet you #{player_name}!"
    puts "Rules: (1) Dealer hits under 17 (2)We are playing with four decks \n\n"
    puts "Let's get started! \n\n" 
  else
    puts "Hi #{player_name}, welcome back!"
    puts "Rules: (1) Dealer hits under 17 (2)We are playing with four decks \n\n"
    puts "Let's get started! \n\n" 
  end
  puts "-------------------------------------"
  puts "Dealer Cards:\n\n" 
  if show_dealer_cards
    dealer_hand.map {|card| puts "=> #{card[0]} of #{card[1]}" }
    puts "\nfor a total of #{dealer_total}\n\n\n"
  else
    puts "=> #{dealer_hand[0][0]} of #{dealer_hand[0][1]}"
    puts "=> ########\n\n\n"
  end
  puts "-------------------------------------"
  puts "#{player_name}'s Cards:\n\n" 
  player_hand.map {|card| puts "=> #{card[0]} of #{card[1]}" }
  puts "\nfor a total of #{player_total}\n\n\n"
  puts "-------------------------------------"
end


# deal cards

cards = []
suits = []
deck = []  
cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]
suits = ["\u2660", "\u2666", "\u2663", "\u2665"]
deck = cards.product(suits) # create the first deck
deck.concat(deck).concat(deck) # create the 2nd, 3rd, 4th deck
deck.shuffle! # shuffle the deck

dealer_hand = [] #start with empty dealer hand
player_hand = [] #start with empty player hand

# deal first card
dealer_hand.push(deck.shift)
player_hand.push(deck.shift)

# deal second card
dealer_hand.push(deck.shift) 
player_hand.push(deck.shift)

player_total = calc_cards(player_hand)
dealer_total = calc_cards(dealer_hand)

display_cards(dealer_hand, player_hand, dealer_total, player_total, player_name, returning)

# BEGIN ROUND

# player turn
if player_total == 21
  display_cards(dealer_hand, player_hand, dealer_total, player_total, player_name, returning,true)
  finish_round(dealer_total, player_total)
else
  puts "You have #{player_total}. Do you want to hit or stay?"
  player_action = gets.chomp
  

  while !['hit', 'stay'].include?(player_action)
    puts "Sorry I didn't get that. Plase enter hit or stay."
    player_action = gets.chomp
  end

  
  while player_action == "hit" do
    player_hand << deck.pop
    player_total = calc_cards(player_hand)
    display_cards(dealer_hand, player_hand, dealer_total, player_total, player_name, returning)
    if player_total == 21 || player_total > 21
      display_cards(dealer_hand, player_hand, dealer_total, player_total, player_name, returning,true)
      finish_round(dealer_total, player_total)
      break
    else
      puts "You have #{player_total}. Do you want to hit or stay?"
      player_action = gets.chomp
        while !['hit', 'stay'].include?(player_action)
          puts "Sorry I didn't get that. Plase enter hit or stay."
          player_action = gets.chomp
        end
    end
  end 
end  


# dealer's turn

if player_action == "stay"
  if dealer_total == 21
    display_cards(dealer_hand, player_hand, dealer_total, player_total, player_name, returning, true)
    finish_round(dealer_total,player_total, true)
  end
    while dealer_total < 17
    dealer_hand << deck.pop
    dealer_total = calc_cards(dealer_hand)
    display_cards(dealer_hand, player_hand, dealer_total, player_total, player_name, returning, true)
      if dealer_total == 21 || dealer_total > 21
        display_cards(dealer_hand, player_hand, dealer_total, player_total, player_name, returning, true)
        finish_round(dealer_total,player_total)
      end
    end
end

if dealer_total >= 17 && dealer_total < 21 && player_action == "stay"
  display_cards(dealer_hand, player_hand, dealer_total, player_total, player_name, returning, true)
  finish_round(dealer_total,player_total)
end


end # end play_round()

play_again = "yes"
returning = false

while play_again == "yes"
  play_round(player_name, returning)
  puts "\n\nWould you like to play again? yes or no"
  play_again = gets.chomp
  while !['yes', 'no'].include?(play_again)
    puts "Sorry I didn't get that. Plase enter yes or no."
    play_again = gets.chomp
  end
  returning = true
end

puts "\n\nThanks for playing. Goodbye."