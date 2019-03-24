defmodule DETERMAUTOMATATest do
  use ExUnit.Case
  doctest DETERMAUTOMATA

  test "iterate through tape" do
    # creates tape
    tape = String.codepoints("ab")
    # iterates through tape
    Enum.map(tape, fn x -> IO.puts(x) end)
  end

  test "automaton transition" do
    tape = String.codepoints("ab")
    # initial state is q0
    DETERMAUTOMATA.determ_automaton(tape)
  end

end
