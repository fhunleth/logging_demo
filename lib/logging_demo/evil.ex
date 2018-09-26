defmodule LoggingDemo.Evil do
  use GenServer
  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def stop() do
    GenServer.stop(__MODULE__)
  end

  def init(_args) do
    Logger.warn("Hello from #{__MODULE__}")
    Process.send_after(self(), :say_something, delay_millis())
    {:ok, []}
  end

  def handle_info(:say_something, state) do
    Logger.error("oops")
    Process.send_after(self(), :say_something, delay_millis())
    {:noreply, state}
  end

  defp delay_millis() do
    1000 + :rand.uniform(5000)
  end
end
