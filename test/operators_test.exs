defmodule TrileanOperatorsTest do
  use ExUnit.Case
  use Trilean.Operators
  doctest Trilean.Operators

  @test_vector [false, :maybe, true]
  @test_square for a <- @test_vector, b <- @test_vector, do: {a, b}
  @test_cube for {a, b} <- @test_square, c <- @test_vector, do: {a, b, c}

  @doc """
  Test that [boolean algebra laws] are (mostly) satisfied.

  [boolean algebra laws]: https://en.wikipedia.org/wiki/Boolean_algebra#Laws
  """
  describe "Monotone Boolean Algebra Laws:" do
    test "Associativity Laws are satisfied" do
      for {a, b, c} <- @test_cube,
          do: assert((a ||| (b ||| c)) == (a ||| b ||| c))

      for {a, b, c} <- @test_cube,
          do: assert((a &&& (b &&& c)) == (a &&& b &&& c))
    end

    test "Commutativity Laws are satisfied" do
      for {a, b} <- @test_square,
          do: assert((a ||| b) == (b ||| a))

      for {a, b} <- @test_square,
          do: assert((a &&& b) == (b &&& a))
    end

    test "Distributivity Laws are satisfied" do
      for {a, b, c} <- @test_cube,
          do: assert((a &&& (b ||| c)) == ((a &&& b) ||| (a &&& c)))

      for {a, b, c} <- @test_cube,
          do: assert((a ||| (b &&& c)) == ((a ||| b) &&& (a ||| c)))
    end

    test "Identity Laws are satisfied" do
      for a <- @test_vector,
          do: assert((a ||| false) == a)

      for a <- @test_vector,
          do: assert((a &&& true) == a)
    end

    test "Annihilation Laws are satisfied" do
      for a <- @test_vector,
          do: assert((a ||| true) == true)

      for a <- @test_vector,
          do: assert((a &&& false) == false)
    end

    test "Idempotency Laws are satisfied" do
      for a <- @test_vector,
          do: assert((a ||| a) == a)

      for a <- @test_vector,
          do: assert((a &&& a) == a)
    end

    test "Absorbtion Laws are satisfied" do
      for {a, b} <- @test_square,
          do: assert((a &&& (a ||| b)) == a)

      for {a, b} <- @test_square,
          do: assert((a ||| (a &&& b)) == a)
    end
  end

  describe "Nonmonotone Boolean Algebra Laws:" do
    test "Complementation Laws are not fully satisfied" do
      for a <- [false, true],
          do: assert((a &&& ~~~a) == false)

      assert((:maybe &&& ~~~:maybe) == :maybe)

      for a <- [false, true],
          do: assert((a ||| ~~~a) == true)

      assert((:maybe ||| ~~~:maybe) == :maybe)
    end

    test "Involution Law is satisfied" do
      for a <- @test_vector,
          do: assert(~~~(~~~a) == a)
    end

    test "De Morgan's Laws are satisfied" do
      for {a, b} <- @test_square,
          do: assert((~~~a &&& ~~~b) == ~~~(a ||| b))

      for {a, b} <- @test_square,
          do: assert(~~~a ||| ~~~b == ~~~(a &&& b))
    end
  end
end
