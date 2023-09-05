defmodule InsigniaNotify.Find do
  alias InsigniaNotify.HandleResponse
  alias InsigniaNotify.Parse
  alias InsigniaNotify.State

  def find_games_row({:ok, html}, games_table_rows_selector, games_state_name) do
    Floki.find(html, games_table_rows_selector)
    |> Enum.map(fn row -> Parse.parse_games_row(row) end)
    |> State.update(games_state_name)
  end

  def find_games_row({:error, reason}, _, _),
    do: HandleResponse.response(:error, reason)

  def find_insignia_stats({:ok, html}, stats_selector, stats_state_name) do
    Floki.find(html, stats_selector)
    |> Parse.parse_stats()
    |> State.update(stats_state_name)
  end

  def find_insignia_stats({:error, reason}, _, _),
    do: HandleResponse.response(:error, reason)
end
