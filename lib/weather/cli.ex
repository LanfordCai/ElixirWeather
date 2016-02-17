defmodule Weather.CLI do

  @moduledoc """
  Handle the command line parsing and dispatching to the respective functions
  that list the weather conditions of provided city.
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  'argv' can be -h or --help, which returns :help.

  Otherwise it is the name of a China city in Chinese.

  Return a string of city name, or ':help' if help was given.
  """
  defp parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ], aliases: [ h: :help ])
    case parse do
      { [ help: true ], _, _ } -> :help
      { _, [ city ], _ } -> city
      _ -> :help
    end
  end

  @doc """
  Prints the help message if the command line argv is -h or --help.
  """
  defp process(:help) do
    IO.puts """
    Usage: weather <city>, For example: weather 广州
    """
    System.halt(0)
  end

  @doc """
  Fetches the weather_info of the city specified, and finally prints the weather condition
  of that city.
  """
  defp process(city) do
    IO.puts """
    Processing...
    """
    Weather.WeatherFetcher.fetch_weather(city)
    |> decode_response
  end

  @doc """
  If the weather_info successfully fetched, format the data into some tables and prints them out.
  """
  defp decode_response({:ok, body}) do
    weather_info = body |> Map.get("HeWeather data service 3.0")
    [info | _] = weather_info
    Weather.TableFormatter.print_info(info)
  end

  @doc """
  In case there is an error when fetching data, prints the error message and the application
  exists with code 2
  """
  defp decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error Fetching WeatherInfo: #{message}"
    System.halt(2)
  end

end
