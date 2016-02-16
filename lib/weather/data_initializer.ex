defmodule Weather.DataInitializer do

  def process do
    data_fetcher
    |> data_parser
    |> Enum.map(fn str -> list_to_key_value_pair(str) end)
    |> Enum.reduce(%{}, fn (x, acc) -> Enum.into(acc, x) end)
  end

  defp data_fetcher do
    "~/Desktop/citylist.xml"
    |> Path.expand
    |> File.read
  end

  defp data_parser({ :ok, file_string }) do
    loc_list = Regex.scan(~r/d1=".*?" d2=".*?" /, file_string)
               |> List.flatten
  end

  defp data_parser({ :error, _ }) do
    IO.puts """
      Data Initialization Error
    """
    System.halt(0)
  end

  defp list_to_key_value_pair(loc_string) do
    loc_list = loc_string
               |> String.split(["=\"", "\" "])
    %{ Enum.at(loc_list, 3) => Enum.at(loc_list, 1) }
  end
end
