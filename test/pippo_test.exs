defmodule PippoTest do
  use ExUnit.Case
  doctest Pippo

  test "greets the world" do
    assert Pippo.hello() == :world
  end
end
