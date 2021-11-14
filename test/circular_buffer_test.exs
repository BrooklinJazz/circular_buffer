defmodule CircularBufferTest do
  use ExUnit.Case
  doctest CircularBuffer

  test "reading an empty buffer produces an error" do
    {:error, _} = CircularBuffer.read(%CircularBuffer{capacity: 3})
  end

  @tag :skip
  test "can write then read a single value" do
    buffer = CircularBuffer.write(%CircularBuffer{capacity: 3}, :foo)
    {:ok, val} = CircularBuffer.read(buffer)
    assert val == :foo
  end

  @tag :skip
  test "reading a buffer gets you the oldest value" do
    buffer =
      %CircularBuffer{capacity: 3}
      |> CircularBuffer.write(:foo)
      |> CircularBuffer.write(:bar)
      |> CircularBuffer.write(:baz)

    {:ok, val} = CircularBuffer.read(buffer)
    assert val == :foo
  end

  @tag :skip
  test "can pop values" do
    buffer =
      %CircularBuffer{capacity: 3}
      |> CircularBuffer.write(:foo)
      |> CircularBuffer.write(:bar)
      |> CircularBuffer.write(:baz)
      |> CircularBuffer.pop()
      |> CircularBuffer.pop()

    {:ok, val} = CircularBuffer.read(buffer)
    assert val == :baz
  end

  @tag :skip
  test "can overwrite the oldest entry" do
    buffer =
      %CircularBuffer{capacity: 3}
      |> CircularBuffer.write(:foo)
      |> CircularBuffer.write(:bar)
      |> CircularBuffer.write(:baz)
      |> CircularBuffer.write(:bang)

    {:ok, val} = CircularBuffer.read(buffer)
    assert val == :bar
  end

  @tag :skip
  test "clear empties the buffer" do
    buffer =
      %CircularBuffer{capacity: 3}
      |> CircularBuffer.write(:foo)
      |> CircularBuffer.write(:bar)
      |> CircularBuffer.write(:baz)

    {:error, _} = CircularBuffer.read(buffer)
  end
end
