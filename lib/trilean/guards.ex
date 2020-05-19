defmodule Trilean.Guards do
  @moduledoc """
  Guard expressions for three-valued logic.

  ## Example
  ```
  iex> defmodule Picnic do
  ...>   use Trilean.Guards
  ...>   use Trilean.Operators
  ...>
  ...>  def pack_one?(sea_battle, nice_day) when is_possible(sea_battle),
  ...>    do: (sea_battle &&& nice_day) |> Trilean.possible?
  ...>  def pack_one(_,_), do:  false
  ...> end
  ...>
  ...> Picnic.pack_one?(Trilean.maybe(), true)
  true
  ```
  """

  require Trilean.Operators
  import Trilean.Operators, only: [maybe: 0]

  @doc """
  Returns `true` if `term` is a `Trilean.t()` value; otherwise returns `false`.
  Can be used in guard expressions.

  ```
  iex>  (fn x when Trilean.Guards.is_trilean(x) -> :is_trilean; _ -> :not_trilean end).(false)
  :is_trilean
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_trilean(x) -> :is_trilean; _ -> :not_trilean end).(true)
  :is_trilean
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_trilean(x) -> :is_trilean; _ -> :not_trilean end).(Trilean.maybe())
  :is_trilean
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_trilean(x) -> :is_trilean; _ -> :not_trilean end).(:bacon)
  :not_trilean
  ```
  """
  @spec is_trilean(term()) :: Macro.t()
  defguard is_trilean(t) when t in [false, maybe(), true]

  @doc """
  Returns `true` if `term` is `false`; otherwise returns `false`. Can be used in guard expressions.

  ```
  iex>  (fn x when Trilean.Guards.is_false(x) -> :is_false; _ -> :not_false end).(false)
  :is_false
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_false(x) -> :is_false; _ -> :not_false end).(true)
  :not_false
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_false(x) -> :is_false; _ -> :not_false end).(Trilean.maybe())
  :not_false
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_false(x) -> :is_false; _ -> :not_false end).(:bacon)
  :not_false
  ```
  """
  @spec is_false(term()) :: Macro.t()
  defguard is_false(t) when t == false

  @doc """
  Returns `true` if `term` is `maybe`; otherwise returns `false`.  Can be used in guard expressions.

  ```
  iex>  (fn x when Trilean.Guards.is_maybe(x) -> :is_maybe; _ -> :not_maybe end).(Trilean.maybe())
  :is_maybe
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_maybe(x) -> :is_maybe; _ -> :not_maybe end).(false)
  :not_maybe
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_maybe(x) -> :is_maybe; _ -> :not_maybe end).(true)
  :not_maybe
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_maybe(x) -> :is_maybe; _ -> :not_maybe end).(:bacon)
  :not_maybe
  ```
  """
  @spec is_maybe(term()) :: Macro.t()
  defguard is_maybe(t) when t == maybe()


  @doc """
  Returns `false` if `term` is `false`; otherwise returns `true`.
  Can be used in guard expressions.

  ```
  iex>  (fn x when Trilean.Guards.is_possible(x) -> :is_possible; _ -> :not_possible end).(Trilean.maybe())
  :is_possible
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_possible(x) -> :is_possible; _ -> :not_possible end).(false)
  :not_possible
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_possible(x) -> :is_possible; _ -> :not_possible end).(true)
  :is_possible
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_possible(x) -> :is_possible; _ -> :not_possible end).(:bacon)
  :not_possible
  ```
  """
  @spec is_possible(term()) :: Macro.t()
  defguard is_possible(t) when is_trilean(t) and t != false

  @doc """
  Returns `true` if `term` is `true`; otherwise returns `false`.
  Can be used in guard expressions.

  ```
  iex>  (fn x when Trilean.Guards.is_true(x) -> :is_true; _ -> :not_true end).(Trilean.maybe())
  :not_true
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_true(x) -> :is_true; _ -> :not_true end).(false)
  :not_true
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_true(x) -> :is_true; _ -> :not_true end).(true)
  :is_true
  ```
  ```
  iex>  (fn x when Trilean.Guards.is_true(x) -> :is_true; _ -> :not_true end).(:bacon)
  :not_true
  ```
  """
  @spec is_true(term()) :: Macro.t()
  defguard is_true(t) when t == true


  defmacro __using__(_opts), do: quote(do: import(unquote(__MODULE__)))
end
