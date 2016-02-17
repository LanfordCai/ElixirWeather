defmodule CityIDFetcherTest do
  use ExUnit.Case

  import Weather.CityIDFetcher, only: [ fetch_city_id: 1 ]

  test "Successfully fetch city_id of Beijing" do
    assert fetch_city_id("北京") == "CN101010100"
  end

  test "Successfully fetch city_id of MiYun" do
    assert fetch_city_id("密云") == "CN101011300"
  end
end
