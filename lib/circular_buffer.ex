defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @enforce_keys [:capacity]
  defstruct @enforce_keys ++ [store: []]

  @type t :: %__MODULE__{
          capacity: integer,
          store: list()
        }

  @doc """
  Read the oldest entry in the queue, fail if it is empty
  """
  def read(%__MODULE__{store: []}) do
    {:error, :empty_buffer}
  end

  @spec read(t) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    [head | _] = Enum.reverse(buffer.store)
    {:ok, head}
  end

  @doc """
  Removes the oldest entry in the queue, if applicable.

  Brooklin's Note: I've altered the spec to return t instead of :ok.
  """
  @spec pop(t) :: t
  def pop(buffer) do
    [_ | tail] = Enum.reverse(buffer.store)
    %{buffer | store: Enum.reverse(tail)}
  end

  @doc """
  Write a new item in the buffer, fail if is full.

  Brooklin's Note: I've made it so that write will not fail when full
  the test seemed to indicate that was desired.
  If not, it would be simple to rewrite this to error instead of overwrite.
  """
  def write(buffer, item) do
    case length(buffer.store) < buffer.capacity do
      true ->
        %{buffer | store: [item | buffer.store]}

      _ ->
        overwrite(buffer, item)
    end
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(t, any) :: t()
  def overwrite(buffer, item) do
    [_ | tail] = Enum.reverse(buffer.store)
    %{buffer | store: [item | Enum.reverse(tail)]}
  end

  @doc """
  Clear the buffer
  """
  @spec clear(t) :: t()
  def clear(buffer) do
    %__MODULE__{capacity: buffer.capacity}
  end
end
