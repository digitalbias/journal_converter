defmodule CliTest do
  use ExUnit.Case
  doctest JournalConverter

  import JournalConverter.CLI, only: [ parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "filename option passed" do
    assert parse_args(["-f", "filename"]) == { :file, "filename" }
  end

  test "directory option passed" do
    assert parse_args(["-d", "filename"]) == { :directory, "filename" }
  end
end
