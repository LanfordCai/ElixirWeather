defmodule Weather.WeatherFetcher do

  @moduledoc """
  Fetches the weather data with the heweather webservice
  """

  @heweather_url Application.get_env(:weather, :heweather_url)

  @doc """
  Fetches data from heweather and returns the decoded response.
  """
  def fetch_weather(city) do
    city_id(city)
    |> weather_url
    |> HTTPoison.get
    |> handle_response
  end

  @doc """
  Fetches the city_id of specified city.
  """
  defp city_id(city) do
    import Weather.CityIDFetcher, only: [ fetch_city_id: 1 ]
    fetch_city_id(city)
  end

  @doc """
  Returns the weather_url for specified city_id
  """
  defp weather_url(city_id) do
    "#{@heweather_url}/weather?cityid=#{city_id}&key=e7c5a4cb418443969bd8724a24def5ee"
  end

  @doc """
  Returns parsed body after a successful response.
  """
  defp handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end

  @doc """
  Returns parsed error_info in case that an error happened when fetching weather info.
  """
  defp handle_response({ _, %{status_code: _, body: body} }) do
    { :error, Poison.Parser.parse!(body) }
  end

end
