defmodule DETERMAUTOMATATest do
  use ExUnit.Case
  doctest DETERMAUTOMATA

  test "iterate through tape" do
    # creates tape
    tape = String.codepoints("ab")
    # iterates through tape
    DETERMAUTOMATA.read(tape)
  end

  test "list manipulation" do
    tape = String.codepoints("")
    assert List.first(tape) == nil
  end

  test "automaton transition" do
    tape = String.codepoints("ab")
    assert DETERMAUTOMATA.determ_automaton(tape) == true
  end

end
