defmodule JournalConverter.TextFormatter do
  def format(filename, date) do
    File.read!(filename)
    |> put_date_into_file(date)
    |> write_file(filename)
  end

  defp write_file(contents, filename) do
    append_day_one_extension(filename)
    |> File.write(contents)
  end

  defp put_date_into_file(contents, date) do
    "\tDate: " <> format_date(date) <> " at 5:00:00 AM MDT\n\n" <> contents
  end

  defp format_date(date) do
    Timex.format!(date, "%B %d, %Y", :strftime)
  end

  defp append_day_one_extension(filename) do
    filename <> ".day_one.txt"
  end
end