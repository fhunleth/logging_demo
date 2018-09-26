defmodule LoggingDemo.Demo do
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
    Process.send_after(self(), :say_something, 10_000)
    {:ok, []}
  end

  def handle_info(:say_something, state) do
    Logger.debug("hello!")
    Process.send_after(self(), :say_something, 10_000)
    {:noreply, state}
  end
end
