defmodule CliTest do
  use ExUnit.Case
  doctest Weather

  import Weather.CLI, only: [ run: 1 ]

  test "Fetching WeatherInfo of Beijing" do
    assert run(["北京"]) == "北京"
  end
end
