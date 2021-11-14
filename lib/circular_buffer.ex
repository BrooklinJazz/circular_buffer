defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @enforce_keys [:capacity]
  defstruct @enforce_keys ++ [buffer: []]

  @type t :: %__MODULE__{
          capacity: integer,
          buffer: list()
        }

  @doc """
  Read the oldest entry in the queue, fail if it is empty
  """
  def read(%__MODULE__{buffer: []}) do
    {:error, :empty_buffer}
  end

  @spec read(t) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    [head | _] = Enum.reverse(buffer.buffer)
    {:ok, head}
  end

  @doc """
  Removes the oldest entry in the queue, if applicable.

  Brooklin's Note: I've altered the spec to return t instead of :ok.
  """
  @spec pop(t) :: t
  def pop(buffer) do
    [_ | tail] = Enum.reverse(buffer.buffer)
    %{buffer | buffer: Enum.reverse(tail)}
  end

  @doc """
  Write a new item in the buffer, fail if is full.

  Brooklin's Note: I've made it so that write will not fail when full
  the test seemed to indicate that was desired.
  If not, it would be simple to rewrite this to error instead of overwrite.
  """
  @spec write(t, any) :: t() | {:error, atom}
  def write(%{buffer: buffer, capacity: capacity} = main_buffer, item)
      when length(buffer) >= capacity do
    overwrite(main_buffer, item)
  end

  def write(buffer, item) do
    case length(buffer.buffer) < buffer.capacity do
      true ->
        %{buffer | buffer: [item | buffer.buffer]}

      _ ->
        overwrite(buffer, item)
    end
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(t, any) :: t()
  def overwrite(buffer, item) do
    [_ | tail] = Enum.reverse(buffer.buffer)
    %{buffer | buffer: [item | Enum.reverse(tail)]}
  end

  @doc """
  Clear the buffer
  """
  @spec clear(t) :: t()
  def clear(buffer) do
    %__MODULE__{capacity: buffer.capacity}
  end
end
