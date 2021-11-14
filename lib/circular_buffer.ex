defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @enforce_keys [:capacity]
  # ++ [others?]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          capacity: integer
        }

  @doc """
  Read the oldest entry in the queue, fail if it is empty
  """
  @spec read(t) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    :not_implemented
  end

  @doc """
  Removes the oldest entry in the queue, if applicable.
  """
  @spec pop(t) :: t
  def pop(buffer) do
    :not_implemented
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(t, any) :: :ok | {:error, atom}
  def write(buffer, item) do
    :not_implemented
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(t, any) :: :ok
  def overwrite(buffer, item) do
    :not_implemented
  end

  @doc """
  Clear the buffer
  """
  @spec clear(t) :: :ok
  def clear(buffer) do
    :not_implemented
  end
end
