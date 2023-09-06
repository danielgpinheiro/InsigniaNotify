defmodule InsigniaNotify do
  alias InsigniaNotify.Find
  alias InsigniaNotify.Http
  alias InsigniaNotify.Job.Execute
  alias InsigniaNotify.State

  @base_url "http://localhost:8080"
  # @games_table_rows_selector "#games table tbody tr:nth-child(-n+3)"
  @games_table_rows_selector "#games table tbody tr:nth-child(1)"
  @stats_selector "section#connect"
  @games_state_name :games
  @stats_state_name :stats

  def run do
    # Execute.start(:normal, :args)
    State.start_link(@games_state_name, @stats_state_name)

    get_and_parse()
  end

  def get_and_parse do
    Http.get(@base_url)
    |> parse_document()
  end

  defp parse_document({:ok, body}) do
    document = Floki.parse_document(body)

    previous_games_state = State.get(@games_state_name)

    Find.find_games_row(document, @games_table_rows_selector, @games_state_name)
    Find.find_insignia_stats(document, @stats_selector, @stats_state_name)

    current_games_state = State.get(@games_state_name)

    check_active_players({previous_games_state, current_games_state})
  end

  defp check_active_players({prev_state, curr_state}) do
    new_prev_state =
      if Enum.empty?(prev_state) do
        curr_state
      else
        prev_state
      end

    Enum.map(curr_state, fn game ->
      game_serial = Map.get(game, :serial)
      game_active_players = Map.get(game, :active_players)

      prev_state_game =
        Enum.find(new_prev_state, fn game -> Map.get(game, :serial) == game_serial end)

      prev_game_active_players = Map.get(prev_state_game, :active_players)

      IO.inspect(game_serial)

      if prev_game_active_players < game_active_players do
        IO.inspect("ta maior")
      end

      if prev_game_active_players > game_active_players do
        IO.inspect("ta menor")
      end

      if prev_game_active_players == game_active_players do
        IO.inspect("ta igual")
      end

      IO.inspect("===========")
    end)
  end
end
