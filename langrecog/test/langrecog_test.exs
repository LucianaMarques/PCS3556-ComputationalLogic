defmodule LANGRECOGTest do
  use ExUnit.Case
  doctest LANGRECOG

  test "greets the world" do
    assert LANGRECOG.hello() == :world
  end
end
