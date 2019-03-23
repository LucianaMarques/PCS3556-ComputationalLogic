defmodule DETERMAUTOMATA do
  @moduledoc """
  Documentation for DETERMAUTOMATA.
  """

  @doc """
  Automaton's main functionality
  """
  def determ_automaton(tape) do
    current_state = :q0
    Enum.map(tape, fn x -> current_state = automata_transition(current_state,x) end)
    IO.puts(current_state)
  end

  @doc """
  Computes the automaton's transitions.
  q2 is accept state, all other are rejection
  """
  def automata_transition(current_state, input) do
    if (current_state == :q0) do
      if (input == :a) do
        :q1
      else
        :q2
      end
    end
    if (current_state == :q1) do
      if (input == :a) do
        :q3
      else
        :q2
      end
    end
    if (current_state == :q2) do
      :q2
    end
    if (current_state == :q3) do
      :q3
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
