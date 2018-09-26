defmodule LoggingDemo.Evil do
  use GenServer
  require Logger

  def start_link(args \\ []) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def stop() do
    GenServer.stop(__MODULE__)
  end

  def init(_args) do
    Logger.warn("Initialized #{__MODULE__}")
    Process.send_after(self(), :say_something, delay_millis())
    {:ok, []}
  end

  def handle_info(:say_something, state) do
    Logger.log(rand_level(), say())
    Process.send_after(self(), :say_something, delay_millis())
    {:noreply, state}
  end

  defp delay_millis() do
    500 + :rand.uniform(3000)
  end

  def rand_level() do
    Enum.random([:error, :warn, :info, :debug])
  end

  def say() do
    "Evil say \"#{rand_message()}\""
  end

  def rand_message() do
    Enum.random([
      "oops",
      "I might have made a mistake",
      "this seems important",
      "debug debug",
      "did it",
      "look at me",
      "surprise",
      "einval",
      "authenticated fhunleth, password nerves",
      "success",
      "hack hack hack"
    ])
  end
end
