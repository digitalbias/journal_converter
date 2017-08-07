defmodule JournalConverterTest do
  use ExUnit.Case
  doctest JournalConverter

  test "greets the world" do
    assert JournalConverter.hello() == :world
  end
end
