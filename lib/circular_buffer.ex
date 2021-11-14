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
  @spec read(t) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    case buffer.store do
      [] ->
        {:error, :empty_buffer}

      _ ->
        {:ok, buffer.store |> Enum.reverse() |> hd()}
    end
  end

  @doc """
  Removes the oldest entry in the queue, if applicable.
  """
  @spec pop(t) :: t
  def pop(buffer) do
    case buffer.store do
      [] ->
        buffer

      _ ->
        %{buffer | store: buffer.store |> Enum.reverse() |> tl() |> Enum.reverse()}
    end
  end

  @doc """
  Write a new item in the buffer, overwrite if it is full.
  """
  def write(buffer, item) do
    if length(buffer.store) < buffer.capacity do
      %{buffer | store: [item | buffer.store]}
    else
      overwrite(buffer, item)
    end
  end

  @spec overwrite(t, any) :: t()
  defp overwrite(buffer, item) do
    %{buffer | store: [item | pop(buffer).store]}
  end

  @doc """
  Clear the buffer
  """
  @spec clear(t) :: t()
  def clear(buffer) do
    %__MODULE__{capacity: buffer.capacity}
  end
end
