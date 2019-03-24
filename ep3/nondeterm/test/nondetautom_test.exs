defmodule NONDETAUTOMTest do
  use ExUnit.Case
  doctest NONDETAUTOM

  test "automaton transition" do
    tape = String.codepoints("aa")
    NONDETAUTOM.determ_automaton(tape)
    assert NONDETAUTOM.determ_automaton(tape) == false
  end
end
