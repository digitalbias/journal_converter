defmodule JournalConverter.Converter do
  def convert_file(filename) do
    contents = File.read!(filename)
    { :ok, date } = filename_to_date(filename)
    new_contents = put_date_into_file(date, contents)
    File.write!(filename <> ".day_one.txt", new_contents)
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
    "\tDate: " <> format_date(date) <> " at 5:00:00 AM MDT\n\n" <> contents
  end

  def format_date(date) do
    Timex.format!(date, "%B %d, %Y", :strftime)
  end
end
