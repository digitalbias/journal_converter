defmodule JournalConverter.CLI do

  @moduledoc """
  Handle the command line parsing and the dispatch to the various function that end up
  converting a markdown journal file to a file that can be imported by DayOne
  """
  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be either -h or --help, which retusn :help.

  Otherwise it is a directory or file that should be converted.

  Return a new file (or directory of files) with `_day1` at the end, or help if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean,
                                                file: :boolean],
                                     aliases:  [h: :help, f: :file])
    case parse do
      { [ help: true ],                       _, _ } -> :help
      { [ file: true ],            [ filename ], _ } -> { :file, filename }
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: journal_converter -f <filename>| -d <directory>
    """
    System.halt(0)
  end

  def process({:file, filename}) do
    JournalConverter.Converter.convert(filename)
  end
end
