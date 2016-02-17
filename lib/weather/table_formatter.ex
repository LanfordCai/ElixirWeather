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
    IO.puts "城    市: #{get_in(info, ["basic", "city"])}"
  end

  @doc """
  Print current condition
  """
  def print_current_weather(info) do
    IO.puts "当前天气"
    IO.puts "天    气: #{get_in(info, ["now", "cond", "txt"])}"
    IO.puts "温    度: #{get_in(info, ["now", "tmp"])}摄氏度"
    IO.puts "湿    度: #{get_in(info, ["now", "hum"])}%"
    IO.puts "风    力: #{get_in(info, ["now", "wind", "sc"])}级"
  end

  def print_current_air_condition(info) do
    IO.puts "空气质量"
    air = get_in(info, ["aqi", "city"])
    IO.puts "等    级: #{get_in(air, ["qlty"])}"
    IO.puts "PM   2.5: #{get_in(air, ["pm25"])}"
    IO.puts "PM    10: #{get_in(air, ["pm10"])}"
  end

  def print_recent_weather(info) do
    IO.puts String.rjust("近期天气", 43)
    IO.puts String.duplicate("-", 89)
    print_forecast_header()
    recent = Map.get(info, "daily_forecast")
    print_weather_condition(recent)
  end

  defp print_forecast_header() do
    header = [String.rjust("日    期", 9), "温    度", "日间天气", "晚间天气", "湿    度", "风    力"]
    IO.puts Enum.join(header, "   |   ")
    line = List.duplicate(String.duplicate("-", 14), 6)
    IO.puts Enum.join(line, "+")
  end

  defp print_weather_condition([]) do
    IO.puts String.duplicate("-", 89)
  end
  defp print_weather_condition([head | tail]) do
    row = [ String.ljust("#{get_in(head, ["date"])}", 13),
            String.ljust("#{get_in(head, ["tmp", "min"])}~#{get_in(head, ["tmp", "max"])}摄氏度", 9),
            special_string_dealer("#{get_in(head, ["cond", "txt_d"])}"),
            special_string_dealer("#{get_in(head, ["cond", "txt_n"])}"),
            String.ljust("#{get_in(head, ["hum"])}%", 12),
            "#{get_in(head, ["wind", "sc"])}级" 
          ]
    IO.puts Enum.join(row, " | ")
    print_weather_condition(tail)
  end

  defp special_string_dealer(string) do
    String.ljust(string, 12 - String.length(string))
  end

end
