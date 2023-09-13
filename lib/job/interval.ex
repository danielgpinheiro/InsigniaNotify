defmodule InsigniaNotify.Job.Interval do
  use GenServer, restart: :transient

  @time 300_000

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    IO.puts("InsigniaNotify.Job.Interval init")

    Process.send_after(self(), :tick, @time)

    {:ok, opts}
  end

  @impl true
  def handle_info(:tick, state) do
    time =
      DateTime.utc_now()
      |> DateTime.to_time()
      |> Time.to_iso8601()

    IO.puts("Tick - #{time}")

    InsigniaNotify.get_and_parse()

    Process.send_after(self(), :tick, @time)

    {:noreply, state}
  end
end
