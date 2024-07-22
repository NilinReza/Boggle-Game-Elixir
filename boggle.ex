defmodule Boggle do
  def boggle(board, words) do
    board = Tuple.to_list(board) |> Enum.map(&Tuple.to_list/1)
    words
    |> Enum.reduce(%{}, fn word, acc ->
      #IO.puts("Finding word: #{word}")
      case find_word(board, word) do
        {:halt, coordinates} ->
          #IO.puts("Found word: #{word} at coordinates: #{inspect(Tuple.to_list(coordinates))}")
          Map.put(acc, word, Tuple.to_list(coordinates))
        _ ->
          #IO.puts("Did not find word: #{word}")
          acc
      end
    end)
  end

  defp find_word(board, word) do
  Enum.find_value(Enum.with_index(board), fn {row, row_index} ->
    Enum.find_value(Enum.with_index(row), fn {cell, col_index} ->
      if start_with?(cell, String.first(word)) do
        #IO.puts("Starting word: #{word} at position: #{row_index}, #{col_index}")
        path = traverse(board, row_index, col_index, String.slice(word, 1..-1//1), {{row_index, col_index}})
        if path != {}, do: path
      end
    end)
  end)
end


  defp start_with?(cell, letter) do
    result = cell == letter
    #IO.inspect({cell, letter, result}, label: "start_with?")
    result
  end


defp tuple_member?(tuple, value) do
  tuple |> Tuple.to_list() |> Enum.member?(value)
end

  defp traverse(_board, _row, _col, word, path) when word == "" do
  {:halt, path}
end

defp traverse(board, row, col, word, path) do
  #IO.inspect({row, col, word, path}, label: "traverse")
  directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]
  Enum.reduce_while(directions, {}, fn {dx, dy}, _acc ->
    new_row = row + dx
    new_col = col + dy
    new_pos = {new_row, new_col}
    #IO.inspect({new_row, new_col, new_pos}, label: "new position")
    if valid?(board, new_row, new_col) && start_with?(Enum.at(Enum.at(board, new_row), new_col), String.first(word)) && !tuple_member?(path, new_pos) do
      #IO.puts("Valid position: #{new_row}, #{new_col}")
      result = traverse(board, new_row, new_col, String.slice(word, 1..-1//1), Tuple.append(path, new_pos))
      #IO.inspect(result, label: "result")
      if result != {}, do: {:halt, result}, else: {:cont, {}}
    else
      {:cont, {}}
    end
  end)
end


  defp valid?(board, row, col) do
    is_valid = row >= 0 && row < length(board) && col >= 0 && col < length(Enum.at(board, row))
    #IO.inspect({row, col, is_valid}, label: "valid?")
    is_valid
  end
end
