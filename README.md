# Trilean

An implementation of the K3+ [three-valued logic](https://en.wikipedia.org/wiki/Three-valued_logic). The third value in this library is `Trilean.maybe()` This is an extension of Kleene's strong logic of indeterminacy.

Three value logics allow reasoning in face of uncertainty. For example

```
iex> will_a_sea_battle_be_fought_tomorrow = Trilean.maybe()
...> nice_day_tomorrow = true
...>
...> _should_i_pack_a_picnic = (
...>   will_a_sea_battle_be_fought_tomorrow
...>   |> Trilean.and(nice_day_tomorrow)
...>   |> Trilean.possible?()
...> )
true
```
I should pack a picnic because it will be a nice day and there could be a spectacle to watch. (The sea battle problem is Aristotle's formulation of the [contingent futures problem](https://en.wikipedia.org/wiki/Problem_of_future_contingents) on which three value logics can shed some light.)

```
iex> will_a_sea_battle_be_fought_tomorrow = Trilean.maybe()
...> nice_day_tomorrow = false
...>
...> _should_i_pack_a_picnic = (
...>   will_a_sea_battle_be_fought_tomorrow
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

