defmodule DETERMAUTOMATATest do
  use ExUnit.Case
  doctest DETERMAUTOMATA

  test "iterate through tape" do
    # creates tape
    tape = String.codepoints("ab")
    # iterates through tape
    DETERMAUTOMATA.read(tape)
  end

  test "automaton transition - #1" do
    tape = String.codepoints("abb")
    assert DETERMAUTOMATA.determ_automaton(tape) == true
  end

  test "automaton transition - #2" do
    tape = String.codepoints("aab")
    assert DETERMAUTOMATA.determ_automaton(tape) == false
  end
end
