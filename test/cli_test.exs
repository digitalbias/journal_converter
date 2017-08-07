defmodule CliTest do
  use ExUnit.Case
  doctest JournalConverter

  import JournalConverter.CLI, only: [ parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "one value returned if one given" do
    assert parse_args(["filename"]) == { "filename" }
  end
end
