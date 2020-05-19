defmodule Trilean.Operators do
  @moduledoc """
  Operators for three-valued logic. These are in conflict with the stdlib
  `Bitwise` module, so both modules cannot be in `use` at the same time.

  ## Examples

      iex> use Trilean.Operators
      iex> ~~~maybe()
      maybe()
      iex> ~~~true
      false
      iex> maybe() ||| false
      maybe()
      iex> maybe() &&& true
      maybe()

  """

  require Trilean

  @doc """
  Returns the `maybe` value
  """
  defmacro maybe, do: unquote(Trilean.maybe())

  @doc """
  See `Trilean.not/1`
  """
  defmacro ~~~rhs do
    quote(do: Trilean.not(unquote(rhs)))
  end

  @doc """
  See `Trilean.or/2`
  """
  defmacro lhs ||| rhs do
    quote(do: Trilean.or(unquote(lhs), unquote(rhs)))
  end

  @doc """
  See `Trilean.and/2`
  """
  defmacro lhs &&& rhs do
    quote(do: Trilean.and(unquote(lhs), unquote(rhs)))
  end

  @doc """
  See `Trilean.implies/2`
  """
  defmacro lhs ~> rhs do
    quote(do: Trilean.implies(unquote(lhs), unquote(rhs)))
  end

  @doc """
  See `Trilean.equivalence/2`
  """
  defmacro lhs <~> rhs do
    quote(do: Trilean.equivalence(unquote(lhs), unquote(rhs)))
  end

  defmacro __using__(_opts), do: quote(do: import(unquote(__MODULE__)))
end
