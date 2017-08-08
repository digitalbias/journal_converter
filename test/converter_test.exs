defmodule ConverterTest do
  use ExUnit.Case
  doctest JournalConverter

  import JournalConverter.Converter, only: [ convert_file: 1, convert_directory: 1]

  test "convert a file" do
    assert convert_file("filename") == ""
  end

  test "convert a directory" do
    assert convert_directory("directory_name") == ""
  end
end
