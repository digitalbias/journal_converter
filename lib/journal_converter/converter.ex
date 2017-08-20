defmodule JournalConverter.Converter do
  def convert(filename) do
    if File.dir?(filename) do
      File.ls!(filename)
      |>Enum.map(&convert(Path.expand(filename) <> "/" <> &1))
    else
      cond do
        Path.extname(filename) == ".txt" -> update_file(Path.expand(filename))
        true -> filename
      end
    end
  end

  defp update_file(filename) do
    IO.puts "updating: " <> Path.expand(filename)
    case filename_to_date(filename) do
      { :ok, date } -> create_day_one_file(filename, date)
      { :error, _} -> IO.puts "Skipping invalid file:" <> filename
    end
  end

  defp create_day_one_file(filename, date) do
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

  defp filename_to_date(filename) do
    filename_path = Path.dirname(filename)

    String.replace(filename, filename_path, "")
    |> String.replace("/", "")
    |> String.replace(".md.txt", "")
    |> String.replace(".", "-")
    |> Timex.parse("{YYYY}-{0M}-{0D}")
  end
end
