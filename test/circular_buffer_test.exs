defmodule CircularBufferTest do
  use ExUnit.Case
  doctest CircularBuffer

  test "reading an empty buffer produces an error" do
    {:error, _} = CircularBuffer.read(%CircularBuffer{capacity: 3})
  end

  test "can write then read a single value" do
    buffer = CircularBuffer.write(%CircularBuffer{capacity: 3}, :foo)
    {:ok, val} = CircularBuffer.read(buffer)
    assert val == :foo
  end

  test "reading a buffer gets you the oldest value" do
    buffer =
      %CircularBuffer{capacity: 3}
      |> CircularBuffer.write(:foo)
      |> CircularBuffer.write(:bar)
      |> CircularBuffer.write(:baz)

    {:ok, val} = CircularBuffer.read(buffer)
    assert val == :foo
  end

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

  test "clear empties the buffer" do
    buffer =
      %CircularBuffer{capacity: 3}
      |> CircularBuffer.write(:foo)
      |> CircularBuffer.write(:bar)
      |> CircularBuffer.write(:baz)
      |> CircularBuffer.clear()

    {:error, _} = CircularBuffer.read(buffer)
  end

  @tag timeout: :infinity
  @tag :benchmark
  test "performance test" do
    Benchee.run(
      %{
        "draft" => fn buffer -> buffer |> CircularBuffer.write(1) |> CircularBuffer.read() end
      },
      inputs: %{
        "Small" => %CircularBuffer{capacity: 1},
        "Medium" => %CircularBuffer{capacity: 101, store: Enum.to_list(1..100)},
        "Large" => %CircularBuffer{capacity: 1001, store: Enum.to_list(1..1001)}
      }
    )
  end
end
