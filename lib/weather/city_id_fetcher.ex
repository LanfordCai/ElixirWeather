defmodule Weather.CityIDFetcher do

  @moduledoc """
  Fetches the city_id with the heweather webservice.
  """

  @heweather_url Application.get_env(:weather, :heweather_url)
  @city_id_url "#{@heweather_url}/citylist?search=allchina&key=e7c5a4cb418443969bd8724a24def5ee"

  @doc """
  Fetches city_list of whole China from heweather, and try to find out the specified one in it.
  """
  def fetch_city_id(city) do
    @city_id_url
    |> HTTPoison.get
    |> handle_response(city)
  end

  @doc """
  Try to get the specified city's id after a successful response.
  """
  defp handle_response({ :ok, %{status_code: 200, body: body} }, city) do
    Poison.Parser.parse!(body)
    |> Map.get("city_info")
    |> Enum.find(&(Map.get(&1, "city") == city))
    |> get_id()
  end

  @doc """
  Return the error info when an error occured during the fetch.
  """
  defp handle_response({ _, %{id: _, reason: _} }, city) do
  IO.puts """
  [error] Network Error
  """
  System.halt(2)
  end

  @doc """
  In case that the specified city can't be find out in the city_list, prints the error message
  and halt the application.
  """
  defp get_id(nil) do
    IO.puts """
    [error] City Not Found
    """
    System.halt(2)
  end

  @doc """
  Return the specified city's id.
  """
  defp get_id(map) do
    Map.get(map, "id")
  end

end
