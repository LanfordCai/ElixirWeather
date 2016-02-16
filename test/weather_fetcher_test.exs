defmodule WeatherFetcherTest do
  use ExUnit.Case

  import Weather.WeatherFetcher, only: [ fetch: 1 ]

  test "Fetch the city_id of Beijing" do
    assert fetch("北京") == "101010100"
  end

  test "Fetch the city_id of Miyun" do
    assert fetch("密云") == "101011300"
  end
end
