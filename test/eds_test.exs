defmodule EdsTest do
  use ExUnit.Case
  doctest Eds

  test "greets the world" do
    assert Eds.hello() == :world
  end
end
