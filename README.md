# Trilean

An implementation of some [three-valued logics](https://en.wikipedia.org/wiki/Three-valued_logic). The third value in this library is `Trilean.maybe()`

These logics allow reasoning in the face of uncertainty. Scenarios like the following are possible

```elixir
iex> if func_with_possibly_indeterminate_result()
...>    |> Trilean.L3Logic.and(someother_func_with_possibly_indeterminate_result())
...>    |> Trilean.L3Logic.is_possible() do
...>   something_interesting()
...> end
```

These logics are algebraic in that every operation returns takes zero or more `Trilean.t()`s and returns a `Trilean.t()`. The `truthy?/1` and `falsy?/1` functions on the various logic modules convert `Trilean.t()` into a binary value based on the rules of the logic in question.

## Priest's Logic
`Trilean.PriestLogic` is a three value logic in which the indeterminate value is both true and false simultaneously.

Example
```elixir
iex> Trilean.PriestLogic.and(true, Trilean.maybe())
true
```

```elixir
iex> Trilean.maybe()
...> |> Trilean.PriestLogic.implies(Trilean.maybe())
Trilean.maybe()
```

## Kleene's Logic
`Trilean.KleeneLogic` is a three value logic in which the indeterminate value is neither true nor false.

Example
```elixir
iex> true
...> |> Trilean.PriestLogic.and(Trilean.maybe())
false
```

```elixir
iex> Trilean.maybe()
...> |> Trilean.KleeneLogic.implies(Trilean.maybe())
Trilean.maybe()
```

## Łukasiewicz Logic
`Trilean.L3Logic` is a three value logic in which the true is the only designated truth value and "unknown implies unknown" is true.

Example
```elixir
iex> true
...> |> Trilean.L3Logic.and(Trilean.maybe())
false
```

```elixir
iex> Trilean.maybe()
...> |> Trilean.L3Logic.implies(Trilean.maybe())
true
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `trilean` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:trilean, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/trilean](https://hexdocs.pm/trilean).

