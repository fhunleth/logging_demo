defmodule LoggingDemoTest do
  use ExUnit.Case
  doctest LoggingDemo

  test "greets the world" do
    assert LoggingDemo.hello() == :world
  end
end
