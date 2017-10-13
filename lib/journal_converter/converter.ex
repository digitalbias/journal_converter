defmodule JournalConverter.Converter do
  def convert(filename, format) do
    if File.dir?(filename) do
      File.ls!(filename)
      |>Enum.map(&convert(Path.expand(filename) <> "/" <> &1, format))
    else
      cond do
        Path.extname(filename) == ".txt" -> update_file(Path.expand(filename), format)
        true -> filename
      end
    end
  end

  defp update_file(filename, format) do
    IO.puts "updating: " <> Path.expand(filename)
    case filename_to_date(filename) do
      { :ok, date } -> create_day_one_file(filename, date, format)
      { :error, _} -> IO.puts "Skipping invalid file:" <> filename
    end
  end

  defp filename_to_date(filename) do
    filename_path = Path.dirname(filename)

    String.replace(filename, filename_path, "")
    |> String.replace("/", "")
    |> String.replace(".md.txt", "")
    |> String.replace(".", "-")
    |> Timex.parse("{YYYY}-{0M}-{0D}")
  end

  defp create_day_one_file(filename, date, format) do
    case format do
      'json' -> JournalConverter.JsonFormatter.format(filename, date)
      'txt'  -> JournalConverter.TextFormatter.format(filename, date)
      _      -> JournalConverter.JsonFormatter.format(filename, date)
    end
  end
end
