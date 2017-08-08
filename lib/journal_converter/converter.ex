defmodule JournalConverter.Converter do
  def convert_file(filename) do
    contents = File.read!(filename)
    { :ok, date } = filename_to_date(filename)
    new_contents = put_date_into_file(date, contents)
    File.write!(filename <> ".converted", new_contents)
  end

  def convert_directory(directory_name) do

  end

  def filename_to_date(filename) do
    expanded_filename = Path.expand(filename)
    [[_, year, month, day]] = Regex.scan(~r/[.]+(.+)\.(.+)\.(.+)\.md\.txt$/, expanded_filename)
    year = String.to_integer(String.slice(year, String.length(year) - 4, 4))
    month = String.to_integer(month)
    day = String.to_integer(day)
    Date.new(year, month, day)
  end

  def put_date_into_file(date, contents) do
    "\tDate: " <> Date.to_string(date) <> "\n\n" <> contents
  end
end

	# Date:	August 5, 2017 at 5:06:39 PM MDT
