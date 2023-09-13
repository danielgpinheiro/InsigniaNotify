defmodule InsigniaNotify.Data.State do
  use Agent

  def start_link(args) do
    init = args[:initial_value]
    name = args[:name] || __MODULE__
    IO.puts("Starting agent #{name}")
    Agent.start_link(fn -> init end, name: name)
  end

  def get(state_name) do
    Agent.get(state_name, & &1, :infinity)
  end

  def get_by_value(state_name, variable_name, variable_value) do
    Agent.get(state_name, & &1)
    |> Enum.find(fn map -> map[variable_name] == variable_value end)
  end

  def update(state, state_name) do
    Agent.update(state_name, fn _ -> state end, :infinity)
  end

  def stop do
    Agent.stop(:games)
    Agent.stop(:stats)
  end
end
