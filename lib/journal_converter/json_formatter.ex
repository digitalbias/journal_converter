defmodule JournalConverter.JsonFormatter do
  def format(filename, date) do
    generate_file_content(filename, date)
    |> write_file(filename)
  end

  defp write_file(contents, filename) do
    append_day_one_extension(filename)
    |> File.write(contents)
  end

  defp generate_file_content(filename, date) do
    """
    #{create_header()}
    #{create_entry(File.read!(filename), date)}
    #{create_footer()}
    """
  end

  defp create_header do
    """
    {
      "metadata" : {
        "version" : "1.0"
      },
      "entries" : [
    """
  end

  defp create_entry(entry, date) do
    """
    {
      "timeZone" : "America\/Denver",
      "creationDate" : "#{create_date_entry(date)}",
      "text" : "#{sanitize_entry(entry)}"
    }
    """
  end

  defp sanitize_entry(entry) do
    entry
    |> String.replace("\n", "\\n")
  end

  defp create_footer do
    """
    ]}
    """
  end

  defp create_date_entry(date) do
    format_date(date) <> " at 5:00:00 AM MDT"
  end

  defp format_date(date) do
    Timex.format!(date, "%B %d, %Y", :strftime)
  end

  defp append_day_one_extension(filename) do
    filename <> ".day_one.json"
  end
end