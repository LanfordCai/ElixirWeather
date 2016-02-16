defmodule Weather.WeatherFetcher do
  @user_agent [ {"User-agent", "Elixir cailinfeng@126.com"} ]

  def fetch(city) do
    city_id(city)
    |> weather_url
    |> HTTPoison.get
    |> handle_response
  end

  defp city_id(city) do
    import Weather.DataInitializer, only: [process: 0]
    process
    |> Map.get(city)
  end

  defp weather_url(city_id) do
    "http://www.weather.com.cn/adat/cityinfo/#{city_id}.html"
  end

  defp handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end
  defp handle_response({ _, %{status_code: _, body: body} }) do
    { :error, Poison.Parser.parse!(body) }
  end

end
