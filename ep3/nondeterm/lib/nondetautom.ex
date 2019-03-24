defmodule NONDETAUTOM do
  @moduledoc """
  Documentation for NONDETAUTOM.
  """

  @doc """
  Automaton's main functionality
  """
  def determ_automaton(tape) do
    current_state = "q0"
    automata_transition(current_state,tape)
  end

  @doc """
  Computes the automaton's transitions.
  q2 is accept state, all other are rejection
  """
  def automata_transition(current_state, tape) do
    next_state = get_next_state(current_state, tape)
    if (next_state == "q2") do
      true
    else
      false
    end
  end

  def get_next_state(current_state, tape) do
    IO.puts(current_state)
    cond do
      List.first(tape) == nil -> #end of tape
        current_state

      # This state can be split in two paths
      current_state == "q0" ->
        if (List.first(tape) == "a") do
          tape2 = List.delete_at(tape,0)
          # if path through q1 doesn't work, try trough q3
          if (get_next_state("q1",tape2) == "q1") do
            get_next_state("q3",tape2)
          end
        end

      current_state == "q1" ->
        if (List.first(tape) == "nil") do
          current_state
        else
          tape2 = List.delete_at(tape,0)
          get_next_state("q2",tape2)
        end

      current_state == "q2" ->
        if (List.first(tape) == nil) do
          current_state
        else
          tape2 = List.delete_at(tape,0)
          get_next_state("q4",tape2)
        end

      current_state == "q3" ->
        tape2 = List.delete_at(tape,0)
        get_next_state("q3",tape2)

      current_state == "q4" ->
        tape2 = List.delete_at(tape,0)
        get_next_state("q4",tape2)
    end
  end

  @doc """
  Reads recursively an input tape
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
