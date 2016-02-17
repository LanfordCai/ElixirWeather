defmodule Weather.TableFormatter do

  @moduledoc """
  Is formatting the results of the fetched data into a table.
  """

  def print_info(info) do
    print_location(info)
    print_current_weather(info)
    print_current_air_condition(info)
    print_recent_weather(info)
  end

  def print_location(info) do
    IO.puts "\n城    市: #{get_in(info, ["basic", "city"])}\n"
  end

  @doc """
  Print current condition
  """
  def print_current_weather(info) do
    IO.puts String.rjust("当前天气", 23)
    IO.puts String.duplicate("-", 59)
    header = [String.rjust("天    气", 9), "温    度", "湿    度", "风    力"]
    print_header(header, 14, 4)
    row = [
      " " <> special_string_dealer("#{get_in(info, ["now", "cond", "txt"])}", 12),
      String.ljust("#{get_in(info, ["now", "tmp"])}摄氏度", 9),
      String.ljust("#{get_in(info, ["now", "hum"])}%", 12),
      "#{get_in(info, ["now", "wind", "sc"])}级"
    ]
    IO.puts Enum.join(row, " | ")
    IO.puts String.duplicate("-", 59) <> "\n"
  end

  def print_current_air_condition(info) do
    IO.puts String.rjust("空气质量", 20)
    IO.puts String.duplicate("-", 44)
    header = [String.rjust("等    级", 9), "PM   2.5", "PM    10"]
    print_header(header, 14, 3)
    air = get_in(info, ["aqi", "city"])
    row = [
      " " <> special_string_dealer("#{get_in(air, ["qlty"])}", 12),
      String.ljust("#{get_in(air, ["pm25"])}", 12),
      String.ljust("#{get_in(air, ["pm10"])}", 12)
    ]
    IO.puts Enum.join(row, " | ")
    IO.puts String.duplicate("-", 44) <> "\n"
  end

  defp print_air_condition_header() do
    IO.puts Enum.join(header, "   |   ")
    line = List.duplicate
  end

  def print_recent_weather(info) do
    IO.puts String.rjust("近期天气", 43)
    IO.puts String.duplicate("-", 89)
    header = [String.rjust("日    期", 9), "温    度", "日间天气", "晚间天气", "湿    度", "风    力"]
    print_header(header, 14, 6)
    recent = Map.get(info, "daily_forecast")
    print_weather_condition(recent)
  end

  defp print_header(header_list, cell_width, column_number) do
    IO.puts Enum.join(header_list, "   |   ")
    line = List.duplicate(String.duplicate("-", cell_width), column_number)
    IO.puts Enum.join(line, "+")
  end

  defp print_weather_condition([]) do
    IO.puts String.duplicate("-", 89)
  end
  defp print_weather_condition([head | tail]) do
    row = [
      " " <> String.ljust("#{get_in(head, ["date"])}", 12),
      String.ljust("#{get_in(head, ["tmp", "min"])}~#{get_in(head, ["tmp", "max"])}摄氏度", 9),
      special_string_dealer("#{get_in(head, ["cond", "txt_d"])}", 12),
      special_string_dealer("#{get_in(head, ["cond", "txt_n"])}", 12),
      String.ljust("#{get_in(head, ["hum"])}%", 12),
      "#{get_in(head, ["wind", "sc"])}级"
    ]
    IO.puts Enum.join(row, " | ")
    print_weather_condition(tail)
  end

  defp special_string_dealer(string, content_width) do
    String.ljust(string, content_width - String.length(string))
  end

end
