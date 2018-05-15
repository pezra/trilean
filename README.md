# Trinary

An implementation of some [three-valued logics](https://en.wikipedia.org/wiki/Three-valued_logic). The third value in this library is `Trinary.maybe()`

These logics allow reasoning in the face of uncertainty. Scenarios like the following are possible

```elixir
iex> if func_with_possibly_indeterminate_result()
...>    |> Trinary.L3Logic.and(someother_func_with_possibly_indeterminate_result())
...>    |> Trinary.L3Logic.is_possible()
...>    |> Trinary.L3Logic.truthy?() do
...>   something_interesting()
...> end
```

These logics are algebraic in that every operation returns takes zero or more `Trinary.t()`s and returns a `Trinary.t()`. The `truthy?/1` and `falsy?/1` functions on the various logic modules convert `Trinary.t()` into a binary value based on the rules of the logic in question.

## Priest's Logic
`Trinary.PriestLogic` is a three value logic in which the indeterminate value is both true and false simultaneously.

Example
```elixir
iex> Trinary.PriestLogic.and(true, Trinary.maybe())
...> |> Trinary.is_true()
true
```

```elixir
iex> Trinary.maybe()
...> |> Trinary.PriestLogic.implies(Trinary.maybe())
Trinary.maybe()
```

## Kleene's Logic
`Trinary.KleeneLogic` is a three value logic in which the indeterminate value is neither true nor false.

Example
```elixir
iex> true
...> |> Trinary.PriestLogic.and(Trinary.maybe())
...> |> Trinary.is_true()
false
```

```elixir
iex> Trinary.maybe()
...> |> Trinary.KleeneLogic.implies(Trinary.maybe())
Trinary.maybe()
```

## Łukasiewicz Logic
`Trinary.L3Logic` is a three value logic in which the true is the only designated truth value and "unknown implies unknown" is true.

Example
```elixir
iex> true
...> |> Trinary.L3Logic.and(Trinary.maybe())
...> |> Trinary.is_true()
false
```

```elixir
iex> Trinary.maybe()
...> |> Trinary.L3Logic.implies(Trinary.maybe())
true
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `trinary` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:trinary, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/trinary](https://hexdocs.pm/trinary).

