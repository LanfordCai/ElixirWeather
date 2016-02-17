defmodule Weather.WeatherFetcher do
  @user_agent [ {"User-agent", "Elixir cailinfeng@126.com"} ]

  def fetch_weather(city) do
    city_id(city)
    |> weather_url
    |> HTTPoison.get
    |> handle_response
  end

  defp city_id(city) do
    import Weather.CityIDFetcher, only: [ fetch_city_id: 1 ]
    fetch_city_id(city)
  end

  defp weather_url(city_id) do
    "https://api.heweather.com/x3/weather?cityid=#{city_id}&key=e7c5a4cb418443969bd8724a24def5ee"
  end

  defp handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end
  defp handle_response({ _, %{status_code: _, body: body} }) do
    { :error, Poison.Parser.parse!(body) }
  end

end
