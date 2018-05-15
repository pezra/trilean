defmodule Trinary do
  @moduledoc """
  Trinary value representation. This is used in the implementation of [three-valued logics](https://en.wikipedia.org/wiki/Three-valued_logic).

  Example:
  ```
  iex> Trinary.true()
  true
  iex> Trinary.false()
  false
  iex> Trinary.maybe()
  :maybe
  ```
  """
  alias __MODULE__, as: Trinary

  @typedoc """
  A trinary logical value: true, false, or maybe
  """
  @type t :: boolean() | :maybe

  @maybe :maybe

  @doc """
  Returns the maybe value
  """
  @spec maybe() :: Trinary.t()
  def maybe(), do: @maybe

  @doc """
  Returns the true value.

  This provided purely for symmetry with `maybe/0`.
  """
  @spec unquote(:"true")() :: Trinary.t()
  def unquote(:"true")(), do: true

  @doc """
  Return the false value.

  This provided purely for symmetry with `maybe/0`.
  """
  @spec unquote(:"false")() :: Trinary.t()
  def unquote(:"false")(), do: false


end
