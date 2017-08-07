defmodule JournalConverter.CLI do

  @moduledoc """
  Handle the command line parsing and the dispatch to the various function that end up
  converting a markdown journal file to a file that can be imported by DayOne
  """
  def run(argv) do
    parse_args(argv)
  end

  @doc """
  `argv` can be either -h or --help, which retusn :help.

  Otherwise it is a directory or file that should be converted.

  Return a new file (or directory of files) with `_day1` at the end, or help if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases:  [h:    :help   ])
    case parse do
      { [help: true], _, _}
        -> :help
      { _, [file_or_directory_name], _ }
        -> { file_or_directory_name }
      _ -> :help
    end
  end
end