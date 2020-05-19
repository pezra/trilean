defmodule Trilean.Operators do
  @moduledoc """
  Operators for three-valued logic. These are in conflict with the stdlib
  `Bitwise` module, so both modules cannot be in `use` at the same time.

  ## Example
  ```
  iex> use Trilean.Operators
  ...> will_a_sea_battle_be_fought_tomorrow = maybe()
  ...> nice_day_tomorrow = true
  ...>
  ...> _should_i_pack_a_picnic =
  ...>   (will_a_sea_battle_be_fought_tomorrow &&& nice_day_tomorrow)
  ...>   |> Trilean.possible?()
  true
  ```
  """

  require Trilean

  @doc """
  Returns the `maybe` value

  ```
  iex> maybe()
  Trilean.maybe()
  ```
  """
  defmacro maybe, do: unquote(Trilean.maybe())

  @doc """
  See `Trilean.not/1`

  ```
  iex> use Trilean.Operators
  ...> ~~~maybe()
  maybe()
  ```
  ```
  iex> ~~~true
  false
  ```
  ```
  iex> ~~~false
  true
  ```
  """
  defmacro ~~~rhs do
    quote(do: Trilean.not(unquote(rhs)))
  end

  @doc """
  See `Trilean.or/2`

  ```
  iex> maybe() ||| maybe()
  maybe()
  ```
  ```
  iex> maybe() ||| true
  true
  ```
  ```
  iex> maybe() ||| false
  maybe()
  ```
  ```
  iex> false ||| maybe()
  maybe()
  ```
  ```
  iex> false ||| false
  false
  ```
  ```
  iex> true ||| false
  true
  ```
  """
  defmacro lhs ||| rhs do
    quote(do: Trilean.or(unquote(lhs), unquote(rhs)))
  end

  @doc """
  See `Trilean.and/2`

  ```
  iex> maybe() &&& maybe()
  maybe()
  ```
  ```
  iex> maybe() &&& true
  maybe()
  ```
  ```
  iex> maybe() &&& false
  false
  ```
  ```
  iex> false &&& maybe()
  false
  ```
  ```
  iex> false &&& false
  false
  ```
  ```
  iex> true &&& true
  true
  ```
  """
  defmacro lhs &&& rhs do
    quote(do: Trilean.and(unquote(lhs), unquote(rhs)))
  end

  @doc """
  See `Trilean.implies/2`

  ```
  iex> maybe() ~> maybe()
  maybe()
  ```
  ```
  iex> maybe() ~> true
  true
  ```
  ```
  iex> true ~> maybe()
  maybe()
  ```
  ```
  iex> maybe() ~> false
  maybe()
  ```
  ```
  iex> false ~> maybe()
  true
  ```
  ```
  iex> false ~> false
  true
  ```
  ```
  iex> true ~> true
  true
  ```
  """
  defmacro lhs ~> rhs do
    quote(do: Trilean.implies(unquote(lhs), unquote(rhs)))
  end

  @doc """
  See `Trilean.equivalence/2`

    ```
  iex> maybe() <~> maybe()
  maybe()
  ```
  ```
  iex> maybe() <~> true
  maybe()
  ```
  ```
  iex> true <~> maybe()
  maybe()
  ```
  ```
  iex> maybe() <~> false
  maybe()
  ```
  ```
  iex> false <~> maybe()
  maybe()
  ```
  ```
  iex> false <~> false
  true
  ```
  ```
  iex> true <~> true
  true
  ```

  """
  defmacro lhs <~> rhs do
    quote(do: Trilean.equivalence(unquote(lhs), unquote(rhs)))
  end

  defmacro __using__(_opts), do: quote(do: import(unquote(__MODULE__)))
end
