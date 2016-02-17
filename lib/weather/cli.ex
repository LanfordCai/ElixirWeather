defmodule Weather.CLI do
  # http://w1.weather.gov/xml/current_obs/index.xml
  # http://www.weather.com.cn/adat/cityinfo/101291011.html
  @moduledoc """
  Handle the command line parsing and the dispatch to the various
  functions that end up generating a table of the last _n_ issues
  in a github project
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  'argv' can be -h or --help, which returns :help.
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ], aliases: [ h: :help ])
    case parse do
      { [ help: true ], _, _ } -> :help
      { _, [ city ], _ } -> city
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: weather <city>
    """
    System.halt(0)
  end

  def process(city) do
    Weather.WeatherFetcher.fetch_weather(city)
    |> decode_response
  end

  defp decode_response({:ok, body}) do
    weather_info = body
                   |> Map.get("HeWeather data service 3.0")
    [info | _] = weather_info
    Weather.TableFormatter.print_info(info)
  end

  defp decode_response({:error, error}) do
    IO.puts "Error Fetching WeatherInfo"
    System.halt(2)
  end

end
