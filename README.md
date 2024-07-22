# Boggle Solver

This is a Boggle solver implemented in Elixir. It finds all possible words on a given Boggle board using Tuples and Maps to store the Boggle board and the found words respectively.

## How it works

The solver uses a depth-first search algorithm to traverse the Boggle board. It starts from each cell of the board and explores neighboring cells to find valid words.

## Code Overview

The main module is `Boggle` with the primary function `boggle(board, words)`. This function takes a Boggle board and a list of words as input, and returns a map of words found on the board along with their coordinates.

Here's a brief overview of the helper functions:

- `find_word(board, word)`: This function finds a word on the board. It returns the coordinates of the word if found, or an empty map if not.
- `start_with?(cell, letter)`: This function checks if a cell's letter is the same as the given letter.
- `tuple_member?(tuple, value)`: This function checks if a value is a member of a tuple.
- `traverse(board, row, col, word, path)`: This function traverses the board from a given cell. It explores all valid directions and returns the path if the word is found.
- `valid?(board, row, col)`: This function checks if a cell (specified by its row and column) is valid, i.e., it is within the board boundaries.
