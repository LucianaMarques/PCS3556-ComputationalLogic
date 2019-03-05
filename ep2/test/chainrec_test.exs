defmodule CHAINRECTest do
  use ExUnit.Case
  doctest CHAINREC

  test "greets the world" do
    assert CHAINREC.hello() == :world
  end
end
