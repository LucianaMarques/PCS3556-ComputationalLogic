defmodule DETERMAUTOMATA do
  @moduledoc """
  Documentation for DETERMAUTOMATA.
  """
  @doc """
  Automaton's main functionality
  """
  def determ_automaton(tape) do
    current_state = :q0
    IO.puts(current_state)
    accep = automata_transition(current_state,tape)
    IO.puts(accep)
  end

  @doc """
  Computes the automaton's transitions.
  q2 is accept state, all other are rejection
  """
  def automata_transition(current_state, tape) do
    next_state = get_next_state(current_state, tape)
    if (next_state == :q2) do
      IO.puts("Chain accepted")
    else
      IO.puts("Chain not accepted")
    end
  end

  def get_next_state(current_state, tape) do
    cond do
      List.first(tape) == nil -> #end of tape
        current_state

      current_state == :q0 ->
        if (List.first(tape) == :a) do
          List.delete(tape,0)
          get_next_state(:q1,tape)
        else
          List.delete(tape,0)
          get_next_state(:q3,tape)
        end

      current_state == :q1 ->
        if (List.first(tape) == :a) do
          List.delete(tape,0)
          get_next_state(:q3,tape)
        else
          List.delete(tape,0)
          get_next_state(:q2,tape)
        end

      current_state == :q2 ->
        List.delete(tape,0)
        get_next_state(:q2,tape)

      current_state == :q3 ->
        List.delete(tape,0)
        get_next_state(:q3,tape)
    end
  end

  @doc """
  Gets the character at the current position of tape
  nil when tape is over
  """
  def read(tape) do
    if (List.first(tape) == nil) do
      IO.puts("End of tape")
    else
      IO.puts(List.first(tape))
      tape2 = List.delete_at(tape,0)
      read(tape2)
    end
  end

end
