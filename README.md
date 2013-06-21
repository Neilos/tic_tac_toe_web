This repository contains my response to a coding challenge set in 2013 by Evgeny Shadchnev at Makers Academy in London.

It re-uses and adapts my own code from an earlier coding challenge to build a console version of a tic tac toe game.

Tic Tac Toe Sinatra Web App
===========================

Write a tic tac toe game, similar to the sudoku sinatra application. It should be a sinatra app that allows two human players to play tic tac toe on the screen. You don't have to implement the functionality to play with the computer but you're welcome to try (it'll make the task considerably harder)

The system should know if the game is over or if it's in progress. If it's over, it should know what player is the winner (or if it's a draw)

To input the move you have at least two options. Choose any:
  * Make every empty cell a clickable area (a link) and when the user clicks, choose the move (cross or nought) accordingly and update the board after reloading the page. No javascription required.
  * Track the clicks using javascript and update the board without reloading the page. Then have a button to check the results of the game. Javascript required.

Your tic tac toe logic (game over or not etc.) should be in a separate model covered by tests. Feel free to reuse your code from the previous coding challenge.

Have a config.ru file, so that the project could be started by running shotgun.

Have a Rakefile, so that all tests could be started by running shotgun.

Have a config.ru file, so that the project could be started by running shotgun.

Have a Rakefile, so that all tests could be run using "rake test"

Feel free to reuse the code from earlier projects.
