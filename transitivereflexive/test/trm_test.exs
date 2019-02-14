defmodule TRMTest do
  use ExUnit.Case
  doctest TRM

  test "greets the world" do
    assert TRM.hello() == :world
  end
end
