defmodule NONDETAUTOMTest do
  use ExUnit.Case
  doctest NONDETAUTOM

  test "input tape on automaton" do
    tape = String.codepoints("a")
    assert NONDETAUTOM.determ_automaton(tape) == false
  end
end
