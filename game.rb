require_relative 'user_io'
require 'yaml'

class Game
  include UserIO
  @@GUESS_ALLOWED = 8

  attr_reader :board, :wrong_letters, :guess_left, :round

  def initialize(filename)
    @secret = decide_secret filename
    @board = ['_'] * @secret.length
    @wrong_letters = []
    @guess_left = @@GUESS_ALLOWED
    @round = 0
    @is_gameover = false
    @filename = nil
  end

  def save_game
    yaml = YAML.dump self
    Dir.mkdir 'save' unless Dir.exist? 'save'

    if @filename.nil?
      file_no = Dir['save/*'].length
      @filename = "save/game_#{file_no + 1}.yaml"
    end

    File.open(@filename, 'w') do |f|
      f.puts yaml
    end
  end

  def start
    # new_round until @is_gameover
    until @is_gameover
      new_round
      @is_gameover = true if @guess_left.zero?
    end

    display_result_and_secret
  end

  def new_round
    # display chosen letters, guess left, guess
    display_round self

    # accept input. only letter
    new_letter = accept_guess(@board, @wrong_letters)

    if new_letter == 'S'
      # Save game

      save_game
      exit if exit_game?

    else
      @guess_left -= 1
      @round += 1

      right_guess = update_board new_letter.downcase

      if !right_guess
        @wrong_letters << new_letter
      elsif @board.count('_').zero?
        # win
        @is_gameover = true
      end
    end
  end

  private

  def decide_secret(filename)
    f = File.open filename
    words = f.readlines.map(&:chomp)
    f.close
    loop do
      word = words.sample
      return word.downcase if word.length.between?(5, 8)
    end
  end

  def update_board(new_letter)
    # Update the display to reflect whether the letter was correct or incorrect.
    # Return boolean if secret includes the letter
    @board.map!.each_with_index { |space, index| @secret[index] == new_letter ? new_letter : space }
    @secret.include? new_letter
  end

  def display_result_and_secret
    puts "\nRESULT:\n\t#{board.count('_').zero? ? 'You won!' : 'You lost!'}"
    puts "\tThe word is: #{@secret}"
  end
end
