defmodule InsigniaNotify.Job.Execute do
  use Application

  alias InsigniaNotify.Job.Interval

  def start(_type, _args) do
    children = [
      {Interval, 0}
    ]

    opts = [strategy: :one_for_one, name: GenTimer.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
