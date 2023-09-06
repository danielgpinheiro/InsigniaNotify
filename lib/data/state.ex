defmodule InsigniaNotify.Data.State do
  use Agent
  @initial_games_row []
  @initial_stats []

  def start_link(games_state_name, stats_state_name) do
    Agent.start_link(fn -> @initial_games_row end, name: games_state_name)
    Agent.start_link(fn -> @initial_stats end, name: stats_state_name)
  end

  def get(state_name) do
    Agent.get(state_name, & &1)
  end

  def get_by_value(state_name, variable_name, variable_value) do
    Agent.get(state_name, & &1)
    |> Enum.find(fn map -> map[variable_name] == variable_value end)
  end

  def update(state, state_name) do
    Agent.update(state_name, fn _ -> state end)
  end

  def stop do
    Agent.stop(:games)
    Agent.stop(:stats)
  end
end
