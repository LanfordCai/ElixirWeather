defmodule Weather.CityIDFetcher do
  @city_id_url "https://api.heweather.com/x3/citylist?search=allchina&key=e7c5a4cb418443969bd8724a24def5ee"

  def fetch_city_id(city) do
    @city_id_url
    |> HTTPoison.get
    |> handle_response(city)
  end

  defp handle_response({ :ok, %{status_code: 200, body: body} }, city) do
    Poison.Parser.parse!(body)
    |> Map.get("city_info")
    |> Enum.find(&(Map.get(&1, "city") == city))
    |> Map.get("id")
  end

  defp handle_response({ _, %{status_code: _, body: body} }, city) do
    { :error, Poison.Parser.parse!(body) }
  end

end
