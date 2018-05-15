defmodule Trinary.L3Logic do
  @moduledoc """

  Implementation of L3's "strong logic of indeterminacy", a three
  value logic in which the third value is neither true nor false.

  """
  @behaviour Trinary.Logic

  @maybe Trinary.maybe()

  @doc """
  Returns the opposite value.

  Truth table
  |A	| not(A) |
  |---|---     |
  |F	| T      |
  |M	| M      |
  |T	| F      |


  Examples
  ```elixir
  iex> Trinary.L3Logic.not(true)
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.not(false)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.not(Trinary.maybe())
  Trinary.maybe()
  ```

  ```

  """
  @spec unquote(:"not")(Trinary.t()) :: Trinary.t()
  def unquote(:"not")(true), do: false
  def unquote(:"not")(false), do: true
  def unquote(:"not")(@maybe), do: @maybe

  @doc """
  Returns the AND of the inputs.

  Truth table
  |       | F | M | T |
  |---    |---|---|---|
  | **F** | F | F | F |
  | **M** | F | M | M |
  | **T** | F | M | T |

  Examples
  ```elixir
  iex> Trinary.L3Logic.and(true, true)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.and(true, Trinary.maybe())
  Trinary.maybe()
  ```

  ```elixir
  iex> Trinary.L3Logic.and(true, false)
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.and(false, Trinary.maybe())
  false
  ```

  """
  @spec unquote(:"and")(Trinary.t(), Trinary.t()) :: Trinary.t()
  def unquote(:"and")(true, true), do: true
  def unquote(:"and")(false, _), do: false
  def unquote(:"and")(_, false), do: false
  def unquote(:"and")(_, _), do: @maybe


  @doc """
  Returns the OR of the inputs

  Truth table
  |       | F | M | T |
  |---    |---|---|---|
  | **F** | F | M | T |
  | **M** | M | M | t |
  | **T** | T | T | T |

  Examples
  ```elixir
  iex> Trinary.L3Logic.or(true, true)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.or(true, false)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.or(true, Trinary.maybe())
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.or(false, false)
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.or(false, Trinary.maybe())
  Trinary.maybe()
  ```
  """
  @spec unquote(:"or")(Trinary.t(), Trinary.t()) :: Trinary.t()
  def unquote(:"or")(true, _), do: true
  def unquote(:"or")(_, true), do: true
  def unquote(:"or")(false, false), do: false
  def unquote(:"or")(_, _), do: @maybe

  @doc """
  Implementati of the equivalence (↔) logic operator.

  Truth table
  |       | T | M |	F |
  |---    |---|---|---|
  | **T** |	T |	M |	F |
  | **M** | M | M | M |
  | **F** |	F |	M |	T |

  Examples

  ```elixir
  iex> Trinary.L3Logic.equivalence(true, true)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.equivalence(false, false)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.equivalence(Trinary.maybe(), false)
  Trinary.maybe()
  ```
  """
  @spec equivalence(Trinary.t(), Trinary.t()) :: Trinary.t()
  def equivalence(@maybe, _), do: @maybe
  def equivalence(_, @maybe), do: @maybe
  def equivalence(true, true), do: true
  def equivalence(false, false ), do: true
  def equivalence(_,_), do: false

  @doc """
  material implication (→) operator.

  Truth table
  |     |T  | U | F |
  |--  -|---|---|---|
  |**T**|T  | U | F |
  |**U**|T  | T | U |
  |**F**|T  | T | T |

  Examples
  ```elixir
  iex> Trinary.L3Logic.implies(true, true)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.implies(true, false)
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.implies(Trinary.maybe(), false)
  Trinary.maybe()
  ```

  ```elixir
  iex> Trinary.L3Logic.implies(Trinary.maybe(), Trinary.maybe())
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.implies(false, false)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.implies(false, true)
  true
  ```
  """
  @spec implies(Trinary.t(), Trinary.t()) :: Trinary.t()
  def implies(true, false), do: false
  def implies(false, _), do: true
  def implies(_, true), do: true
  def implies(@maybe, @maybe), do: true
  def implies(_, _), do: @maybe

  @doc """
  Implementation of `M` unary logic operator. "it is not false that..." or "it is possible that...".

  Examples

  ```elixir
  iex> Trinary.L3Logic.is_possible(false)
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.is_possible(Trinary.maybe())
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.is_possible(true)
  true
  ```
  """
  @spec is_possible(Trinary.t()) :: Trinary.t()
  def is_possible(false), do: false
  def is_possible(_), do: true

  @doc """
  Implementation of `I` unary logic operator. "it is unknown that..." or "it is contingent that...".

  Examples

  ```elixir
  iex> Trinary.L3Logic.is_unknown(false)
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.is_unknown(Trinary.maybe())
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.is_unknown(true)
  false
  ```

  """
  @spec is_unknown(Trinary.t()) :: Trinary.t()
  def is_unknown(@maybe), do: true
  def is_unknown(_), do: false

    @doc """
  Implementation of `L` unary logic operator. "it is true that..." or "it is necessary that...".

  Examples

  ```elixir
  iex> Trinary.L3Logic.is_true(false)
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.is_true(Trinary.maybe())
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.is_true(true)
  true
  ```

  """
  @spec is_true(Trinary.t()) :: Trinary.t()
  def is_true(true), do: true
  def is_true(_), do: false


  @doc """
  "it is false that...".

  Examples

  ```elixir
  iex> Trinary.L3Logic.is_false(false)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.is_false(Trinary.maybe())
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.is_false(true)
  false
  ```

  """
  @spec is_false(Trinary.t()) :: Trinary.t()
  def is_false(false), do: true
  def is_false(_), do: false


  @doc """
  Implementation of `L` unary logic operator. "it is true that..." or "it is necessary that...".

  Examples

  ```elixir
  iex> Trinary.L3Logic.truthy?(false)
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.truthy?(Trinary.maybe())
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.truthy?(true)
  true
  ```

  """
  @spec truthy?(Trinary.t()) :: boolean()
  defdelegate truthy?(p), to: __MODULE__, as: :is_true

  @doc """
  "it is false that...".
  Examples

  ```elixir
  iex> Trinary.L3Logic.falsy?(false)
  true
  ```

  ```elixir
  iex> Trinary.L3Logic.falsy?(Trinary.maybe())
  false
  ```

  ```elixir
  iex> Trinary.L3Logic.falsy?(true)
  false
  ```

  """
  @spec falsy?(Trinary.t()) :: boolean()
  defdelegate falsy?(p), to: __MODULE__, as: :is_false

end