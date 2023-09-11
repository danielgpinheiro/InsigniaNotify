defmodule InsigniaNotify.Job.Execute do
  use Application

  alias InsigniaNotify.Job.Interval

  def start(_type, _args) do
    children = [
      {Interval, 0},
      Supervisor.child_spec({InsigniaNotify.Data.State, initial_value: [], name: :games}, id: :games),
      Supervisor.child_spec({InsigniaNotify.Data.State, initial_value: [], name: :stats}, id: :stats)
    ]

    opts = [strategy: :one_for_one, name: GenTimer.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
