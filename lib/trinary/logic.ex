
defmodule Trinary.Logic do
  @moduledoc """
  Behaviour for three-value logics
  """

  @callback unquote(:"not")(Trinary.t()) :: Trinary.t()
  @callback unquote(:"and")(Trinary.t(), Trinary.t()) :: Trinary.t()
  @callback unquote(:"or")(Trinary.t(), Trinary.t()) :: Trinary.t()
  @callback equivalence(Trinary.t(), Trinary.t()) :: Trinary.t()
  @callback implies(Trinary.t(), Trinary.t()) :: Trinary.t()
  @callback is_possible(Trinary.t()) :: Trinary.t()
  @callback is_unknown(Trinary.t()) :: Trinary.t()
  @callback is_true(Trinary.t()) :: Trinary.t()
  @callback is_false(Trinary.t()) :: Trinary.t()

  @callback truthy?(Trinary.t()) :: boolean()
  @callback falsy?(Trinary.t()) :: boolean()

end