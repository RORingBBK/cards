defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns the playing cards
  """

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # Good Approach
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

    # Bad approach
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end

    # List.flatten(cards)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether deck contains the given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicated how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, file_name) do
    #:erlang = calling Erlang code
    binary = :erlang.term_to_binary(deck) # Converting to smth that can be written into file system
    File.write(file_name, binary)
  end

  def load(file_name) do
    # {status, binary} = File.read(file_name)

    # case status do
    #   :ok -> :erlang.binary_to_term(binary)
    #   :error -> "That file does not exist"
    # end

    # Refactor of above code
    case File.read(file_name) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      # {:error, reason} -> "That file does not exist"
      {:error, _reason} -> "That file does not exist" # _reason to remove warning of not used variable but it is needed for pattern matching
    end
  end

  # Call all here functions in one function
  def create_hand(hand_size) do
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    # Refactor of above code.
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end

# Cards.deal(deck, 5) # { *hand*, *deck* }
# Cards.deal(deck, 5) # { hand: [], deck: [] }