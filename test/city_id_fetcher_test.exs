defmodule CityIDFetcherTest do
  use ExUnit.Case

  import Weather.CityIDFetcher, only: [ fetch_city_id: 1 ]

  test "Successfully fetch city_list" do
    assert fetch_city_id("北京") == "kkk"
  end
end
