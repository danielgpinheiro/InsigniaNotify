defmodule InsigniaNotify.State do
  use Agent
  @initial_games_row %{}
  @initial_stats %{}

  def start_link(games_state_name, stats_state_name) do
    Agent.start_link(fn -> @initial_games_row end, name: games_state_name)
    Agent.start_link(fn -> @initial_stats end, name: stats_state_name)
  end

  def get(state_name) do
    Agent.get(state_name, & &1)
  end

  def update(state, state_name) do
    Agent.update(state_name, fn _ -> state end)
  end

  def stop do
    Agent.stop(:games)
    Agent.stop(:stats)
  end
end
