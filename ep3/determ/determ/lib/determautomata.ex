defmodule DETERMAUTOMATA do
  @moduledoc """
  Documentation for DETERMAUTOMATA.
  """
  @doc """
  Automaton's main functionality
  """
  def determ_automaton(tape) do
    current_state = :q0
    accep = automata_transition(current_state,tape)
    IO.puts(current_state)
  end

  @doc """
  Computes the automaton's transitions.
  q2 is accept state, all other are rejection
  """
  def automata_transition(current_state, tape) do
    next_state = get_next_state(current_state, tape)
    if (nex_state == :q2) do
      IO.puts("Chain accepted")
    else
      IO.puts("Chain not accepted")
    end
  end

  def get_next_state(current_state, tape) do
    cond do
      first(list) == nil -->
        current_state

  else if (current_state == :q0) do
      if (first(tape) == :a) do
        delete(tape,0)
        automata_transition(:q1,tape)
      else
        delete(tape,0)
        automata_transition(:q3,tape)
      end
    end
    if (current_state == :q1) do
      if (first(tape) == :a) do
        delete(tape,0)
        automata_transition(:q3,tape)
      else
        delete(tape,0)
        automata_transition(:q2,tape,i+1)
      end
    end
    if (current_state == :q2) do
      delete(tape,0)
      automata_transition(:q2,tape)
    end
    if (current_state == :q3) do
      delete(tape,0)
      automata_transition(:q3,tape)
    end
  end

  @doc """
  Gets the character at the current position of tape
  May be nil in case tape is over
  """
  def read(tape,i) do
    String.at(tape,i)
  end

  @doc """
  Moves current position of tape
  """
  def reconfig(i) do
    i + 1
  end
end
