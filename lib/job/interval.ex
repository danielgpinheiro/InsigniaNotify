defmodule InsigniaNotify.Job.Interval do
  use GenServer

  @time 10000
  # @time 300_000

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  def init(opts) do
    Process.send_after(self(), :tick, @time)

    {:ok, opts}
  end

  def handle_info(:tick, state) do
    time =
      DateTime.utc_now()
      |> DateTime.to_time()
      |> Time.to_iso8601()

    IO.puts("#{time}")

    InsigniaNotify.get_and_parse()

    Process.send_after(self(), :tick, @time)

    {:noreply, state}
  end
end
