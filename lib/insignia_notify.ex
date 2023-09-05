defmodule InsigniaNotify do
  alias InsigniaNotify.Find
  alias InsigniaNotify.Http
  alias InsigniaNotify.State

  @base_url "http://localhost:8080"
  @games_table_rows_selector "#games table tbody tr:nth-child(3)"
  @stats_selector "section#connect"
  @games_state_name :games
  @stats_state_name :stats

  def run do
    State.start_link(@games_state_name, @stats_state_name)

    Http.get(@base_url)
    |> parse_document()
  end

  defp parse_document({:ok, body}) do
    document = Floki.parse_document(body)

    Find.find_games_row(document, @games_table_rows_selector, @games_state_name)
    Find.find_insignia_stats(document, @stats_selector, @stats_state_name)
  end
end
