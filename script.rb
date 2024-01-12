require_relative 'game'
require_relative 'user_io'

include UserIO

FILENAME = 'google-10000-english-no-swears.txt'
# FILENAME = 'dict.txt'

unless File.exist? FILENAME
  puts "File doesn't exist. Check your filename."
  exit
end

def new_game
  g = Game.new FILENAME
  p g
  g.start
end

# When the program first loads,
# add in an option that allows you to open one of your saved games,
# which should jump you exactly back to where you were when you saved.

numSavedFiles = Dir['save/*'].length

if numSavedFiles > 0
  if new_game?
    new_game
  else
    # continue from saved game
    file_no = ask_file_no(numSavedFiles)
    g = YAML.load_file("save/game_#{file_no}.yaml", permitted_classes: [Game])
    g.start
  end
else
  new_game
end
