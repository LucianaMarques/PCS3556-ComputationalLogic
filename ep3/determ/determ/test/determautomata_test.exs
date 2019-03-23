defmodule DETERMAUTOMATATest do
  use ExUnit.Case
  doctest DETERMAUTOMATA

  test "iterate through tape" do
    # creates tape
    tape = String.codepoints("ab")
    # iterates through tape
    Enum.map(tape, fn x -> IO.puts(x) end)
  end


end
