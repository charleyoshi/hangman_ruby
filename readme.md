# Hangman - Files and Serialization Practice in Ruby

This is a Files and Serialization practice.

## Description
- When a new game is started, the script loads in the dictionary [google-10000-english](https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt) and randomly select a word between 5 and 12 characters long for the secret word.
- Each round correct letters are displayed e.g. `_ r o g r a _ _ i n g`. Incorrect chosen words are also displayed.
- At the start of any round, the player also has the option to save the game. 
    - The game object is then serialized and saved into a `yaml` file.
- When the program loads again, if there are previously saved games, players can jump back to where they were when they saved.
- You can save multiple games in `yaml` in the same file called `save`. <br/>

- The `Game` class is implemented with encapsulation and private methods.
- `UserIO` is a helper module.


## Executing program
```
ruby script.rb
```

## Authors

ex. Charley Yoshi  
ex. [@charleyoshi](https://charleyoshi.com)

