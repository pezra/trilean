defmodule Trilean.Guards do
  @moduledoc """
  Guard expressions for three-valued logic.

  ## Examples

      iex> use Trilean.Guards
      iex> f = fn x when is_trilean(x) -> x; _ -> nil end
      iex> f.(Trilean.maybe())
      Trilean.maybe()
      iex> f.(:bacon)
      nil
  """

  require Trilean.Operators
  import Trilean.Operators, only: [maybe: 0]

  @doc """
  Returns `true` if `term` is `false`; otherwise returns `false`.
  Can be used in guard expressions.
  """
  @spec is_false(term()) :: Macro.t()
  defguard is_false(t) when t == false

  @doc """
  Returns `true` if `term` is `maybe`; otherwise returns `false`.
  Can be used in guard expressions.
  """
  @spec is_maybe(term()) :: Macro.t()
  defguard is_maybe(t) when t == maybe()

  @doc """
  Returns `false` if `term` is `false`; otherwise returns `true`.
  Can be used in guard expressions.
  """
  @spec is_possible(term()) :: Macro.t()
  defguard is_possible(t) when t != false

  @doc """
  Returns `true` if `term` is `true`; otherwise returns `false`.
  Can be used in guard expressions.
  """
  @spec is_true(term()) :: Macro.t()
  defguard is_true(t) when t == true

  @doc """
  Returns `true` if `term` is a `Trilean.t()` value; otherwise returns `false`.
  Can be used in guard expressions.
  """
  @spec is_trilean(term()) :: Macro.t()
  defguard is_trilean(t) when t in [false, maybe(), true]

  defmacro __using__(_opts), do: quote(do: import(unquote(__MODULE__)))
end
