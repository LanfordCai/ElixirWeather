defmodule WeatherFetcherTest do
  use ExUnit.Case

  import Weather.WeatherFetcher, only: [ fetch_weather: 1 ]

  test "Fetch the city_id of Beijing" do
    assert fetch_weather("北京") == "101010100"
  end

  test "Fetch the city_id of Miyun" do
    assert fetch_weather("密云") == "101011300"
  end
end
