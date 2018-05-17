defmodule Trilean do
  @moduledoc """

  Trilean implements a functionally complete [three-valued
  logic](https://en.wikipedia.org/wiki/Three-valued_logic), K3+. This
  is an extension of Kleene's strong logic of indeterminacy.

  Three value logics allow reasoning in face of uncertainty. For example

  ```
  iex> will_there_be_a_sea_battle_tomorrow = Trilean.maybe()
  ...> nice_day_tomorrow = true
  ...>
  ...> _should_i_pack_a_picnic = (
  ...>   will_there_be_a_sea_battle_tomorrow
  ...>   |> Trilean.and(nice_day_tomorrow)
  ...>   |> Trilean.possible?()
  ...> )
  true
  ```
  I should pack a picnic because it will be a nice day and there could be a spectacle to watch. (The sea battle problem is Aristotle's formulation of the [contingent futures problem](https://en.wikipedia.org/wiki/Problem_of_future_contingents) on which three value logics can shed some light.)

  ```
  iex> will_there_be_a_sea_battle_tomorrow = Trilean.maybe()
  ...> nice_day_tomorrow = false
  ...>
  ...> _should_i_pack_a_picnic = (
  ...>   will_there_be_a_sea_battle_tomorrow
  ...>   |> Trilean.and(nice_day_tomorrow)
  ...>   |> Trilean.possible?()
  ...> )
  false
  ```
  I should not pack a picnic even though there could be a spectacle because it will be a crummy day.

  All expressions evaluate the same as they would in normal boolean logic if their inputs are true or false. If, however, one or more of the inputs is `:maybe` then the output may become indeterminate. For example:

  ```
  iex> Trilean.and(true, true)
  true
  iex> Trilean.and(true, false)
  false
  iex> Trilean.and(true, Trilean.maybe())
  Trilean.maybe()
  ```
  """
  alias __MODULE__, as: Trilean

  @typedoc """
  A trinary logical value: true, false, or maybe
  """
  @type t :: boolean() | :maybe

  @maybe :maybe

  @doc """
  Returns the maybe value
  """
  @spec maybe() :: Trilean.t()
  def maybe(), do: @maybe

  @doc """
  Returns the true value.

  This provided for symmetry with `maybe/0`.
  """
  @spec unquote(:"true")() :: Trilean.t()
  def unquote(:"true")(), do: true

  @doc """
  Return the false value.

  This provided for symmetry with `maybe/0`.
  """
  @spec unquote(:"false")() :: Trilean.t()
  def unquote(:"false")(), do: false

  @doc """
  [Logical negation or complement (`¬`)](https://en.wikipedia.org/wiki/Negation)

  Truth table

  |A	| ¬A |
  |---|---     |
  |F	| T      |
  |M	| M      |
  |T	| F      |


  Examples
  ```elixir
  iex> Trilean.not(true)
  false
  ```

  ```elixir
  iex> Trilean.not(false)
  true
  ```

  ```elixir
  iex> Trilean.not(Trilean.maybe())
  Trilean.maybe()
  ```
  """
  @spec unquote(:"not")(Trilean.t()) :: Trilean.t()
  def unquote(:"not")(true), do: false
  def unquote(:"not")(false), do: true
  def unquote(:"not")(@maybe), do: @maybe

  @doc """
  [Logical cyclic negation](https://en.wikipedia.org/wiki/Cyclic_negation)

  Truth table

  |A	| cyclic not(A) |
  |---|---     |
  |**F**	| T      |
  |**M**	| F      |
  |**T**	| M      |


  Examples
  ```elixir
  iex> Trilean.cyc_neg(true)
  Trilean.maybe()
  ```

  ```elixir
  iex> Trilean.cyc_neg(false)
  true
  ```

  ```elixir
  iex> Trilean.cyc_neg(Trilean.maybe())
  false
  ```
  """
  @spec cyc_neg(Trilean.t()) :: Trilean.t()
  def cyc_neg(true), do: @maybe
  def cyc_neg(false), do: true
  def cyc_neg(@maybe), do: false

  @doc """
  [Logical conjunction (`∧`)](https://en.wikipedia.org/wiki/Logical_conjunction)

  Truth table

  |       | F | M | T |
  |---    |---|---|---|
  | **F** | F | F | F |
  | **M** | F | M | M |
  | **T** | F | M | T |

  Examples
  ```elixir
  iex> Trilean.and(true, true)
  true
  ```

  ```elixir
  iex> Trilean.and(true, Trilean.maybe())
  Trilean.maybe()
  ```

  ```elixir
  iex> Trilean.and(true, false)
  false
  ```

  ```elixir
  iex> Trilean.and(false, Trilean.maybe())
  false
  ```

  """
  @spec unquote(:"and")(Trilean.t(), Trilean.t()) :: Trilean.t()
  def unquote(:"and")(true, true), do: true
  def unquote(:"and")(false, _), do: false
  def unquote(:"and")(_, false), do: false
  def unquote(:"and")(_, _), do: @maybe

  @doc """
  [Logical disjunction (`∨`)](https://en.wikipedia.org/wiki/Logical_disjunction)

  Truth table

  |       | F | M | T |
  |---    |---|---|---|
  | **F** | F | M | T |
  | **M** | M | M | t |
  | **T** | T | T | T |

  Examples
  ```elixir
  iex> Trilean.or(true, true)
  true
  ```

  ```elixir
  iex> Trilean.or(true, false)
  true
  ```

  ```elixir
  iex> Trilean.or(true, Trilean.maybe())
  true
  ```

  ```elixir
  iex> Trilean.or(false, false)
  false
  ```

  ```elixir
  iex> Trilean.or(false, Trilean.maybe())
  Trilean.maybe()
  ```
  """
  @spec unquote(:"or")(Trilean.t(), Trilean.t()) :: Trilean.t()
  def unquote(:"or")(true, _), do: true
  def unquote(:"or")(_, true), do: true
  def unquote(:"or")(false, false), do: false
  def unquote(:"or")(_, _), do: @maybe


  @doc """
  [Logical equivalence (`↔` or `≡`)](https://en.wikipedia.org/wiki/Logical_equivalence)

  Truth table

  |       | F | M | T |
  |---    |---|---|---|
  | **F** |	T | M | F |
  | **M** | M | M | M |
  | **T** |	F | M | T |

  Examples

  ```elixir
  iex> Trilean.equivalence(true, true)
  true
  ```

  ```elixir
  iex> Trilean.equivalence(false, false)
  true
  ```

  ```elixir
  iex> Trilean.equivalence(Trilean.maybe(), false)
  Trilean.maybe()
  ```
  """
  @spec equivalence(Trilean.t(), Trilean.t()) :: Trilean.t()
  def equivalence(@maybe, _), do: @maybe
  def equivalence(_, @maybe), do: @maybe
  def equivalence(true, true), do: true
  def equivalence(false, false ), do: true
  def equivalence(_,_), do: false

  @doc """
  [Material implication (`→` or `⊃`)](https://en.wikipedia.org/wiki/Material_implication_(rule_of_inference))

  Truth table

  |     | F | M | T |
  |---  |---|---|---|
  |**F**| T | T | T |
  |**M**| M | M | T |
  |**T**| F | M | T |

  Examples
  ```elixir
  iex> Trilean.implies(true, true)
  true
  ```

  ```elixir
  iex> Trilean.implies(true, false)
  false
  ```

  ```elixir
  iex> Trilean.implies(Trilean.maybe(), false)
  Trilean.maybe()
  ```

  ```elixir
  iex> Trilean.implies(Trilean.maybe(), Trilean.maybe())
  Trilean.maybe()
  ```

  ```elixir
  iex> Trilean.implies(false, false)
  true
  ```

  ```elixir
  iex> Trilean.implies(false, true)
  true
  ```
  """
  @spec implies(Trilean.t(), Trilean.t()) :: Trilean.t()
  def implies(true, false), do: false
  def implies(false, _), do: true
  def implies(_, true), do: true
  def implies(_, _), do: @maybe

  @doc """
  [Logical possibility (or `M` or `◇`)](https://en.wikipedia.org/wiki/Logical_possibility)

  |A	| ◇A |
  |---|---     |
  |**F**	| F      |
  |**M**	| T      |
  |**T**	| T      |

  Examples

  ```elixir
  iex> Trilean.possible?(false)
  false
  ```

  ```elixir
  iex> Trilean.possible?(Trilean.maybe())
  true
  ```

  ```elixir
  iex> Trilean.possible?(true)
  true
  ```
  """
  @spec possible?(Trilean.t()) :: boolean()
  def possible?(false), do: false
  def possible?(_), do: true

  @doc """
  [Logical necessity (or `L` or `□`)](https://www.rit.edu/cla/philosophy/quine/necessity.html)

  Truth table

  | A   | □A |
  |---|---|
  |**F**| T |
  |**M**| F |
  |**T**| T |

  Examples

  ```elixir
  iex> Trilean.true?(false)
  false
  ```

  ```elixir
  iex> Trilean.true?(Trilean.maybe())
  false
  ```

  ```elixir
  iex> Trilean.true?(true)
  true
  ```
  """
  @spec true?(Trilean.t()) :: boolean()
  def true?(true), do: true
  def true?(_), do: false

  @doc """
  Implementation of `I` unary logic operator. "it is unknown that..." or "it is contingent that...".

  |A	| I(A) |
  |---|---     |
  |**F**	| F     |
  |**M**	| T      |
  |**T**	| F      |

  Examples

  ```elixir
  iex> Trilean.maybe?(false)
  false
  ```

  ```elixir
  iex> Trilean.maybe?(Trilean.maybe())
  true
  ```

  ```elixir
  iex> Trilean.maybe?(true)
  false
  ```

  """
  @spec maybe?(Trilean.t()) :: boolean()
  def maybe?(@maybe), do: true
  def maybe?(_), do: false

end
