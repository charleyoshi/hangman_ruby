module UserIO
  # OUTPUT

  def display_round(game)
    # accessible variables(reader) :board, :wrong_letters, :guess_left, :round
    puts "\nRound #{game.round + 1} \nYou have #{game.guess_left} guess#{game.guess_left > 1 ? 'es' : ''} left"
    puts "Wrong letters: #{game.wrong_letters.empty? ? 'empty' : game.wrong_letters.join(', ')}"
    puts game.board.join ' '
  end

  # INPUT

  def accept_guess(board, wrong_letters)
    # new letter can't already exist on board / wrong letters array
    loop do
      print 'Take a new guess: '
      new_letter = gets.chomp.strip
      if new_letter.length != 1 || !new_letter.match?(/[[:alpha:]]/)
        puts 'Please enter a character!'
      elsif (board + wrong_letters - ['_']).include? new_letter
        puts "You have guessed `#{new_letter}` already."
      else
        return new_letter
      end
    end
  end

  def exit_game?
    # return boolean 
    response = ''
    until %w[y n].include?(response)
      print 'Game saved! Exit game? (y/n) '
      response = gets.chomp.downcase
    end
    response == 'y'
  end

  def new_game?
    # return boolean 
    response = ''
    until %w[n s].include?(response)
      print 'Enter `n` for a new game or `s` for a saved game (n/s): '
      response = gets.chomp.downcase
    end
    response == 'n'
  end

  def ask_file_no(numSavedFiles)
    # return integer between 1 and number of saved files 
    response = 0
    until response.between?(1, numSavedFiles)
      print "Enter the game number. You have #{numSavedFiles} saved games. E.g. Enter `1` for game 1. "
      response = gets.chomp.to_i
    end
    response
  end
end
