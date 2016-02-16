defmodule DataInitializerTest do
  use ExUnit.Case

  import Weather.DataInitializer, only: [ process: 0 ]

  test "Initialize Data Correctly" do
    assert process == ["d1=\"101010100\" d2=\"北京\""]
  end
end
