defmodule Mix.Tasks.StartInsigniaNotify do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    InsigniaNotify.run()
  end
end
