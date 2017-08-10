defmodule JournalConverter.Converter do
  def convert(filename) do
    if File.dir?(filename) do
      files = File.ls!(filename)

    else
      { :ok, date }    = filename_to_date(filename)

      File.read!(filename)
      |> put_date_into_file(date)
      |> write_file(filename)
    end
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

  defp filename_to_date(filename) do
    filename_path = Path.expand(filename)
    |> Path.dirname()

    Path.expand(filename)
    |> String.replace(filename_path, "")
    |> String.replace("/", "")
    |> String.replace(".md.txt", "")
    |> String.replace(".", "-")
    |> Timex.parse("{YYYY}-{0M}-{0D}")
  end
end
