defmodule NONDETAUTOMTest do
  use ExUnit.Case
  doctest NONDETAUTOM

  test "input tape on automaton - #1" do
    IO.puts("Test - #1")
    tape = String.codepoints("a")
    assert NONDETAUTOM.determ_automaton(tape) == false
  end

  test "input tape on automaton - #2" do
    IO.puts("Test - #2")
    tape = String.codepoints("aa")
    assert NONDETAUTOM.determ_automaton(tape) == false
  end

  test "input tape on automaton - #3" do
    IO.puts("Test - #3")
    tape = String.codepoints("aaaa")
    assert NONDETAUTOM.determ_automaton(tape) == false
  end
end
