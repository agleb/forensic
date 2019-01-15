defmodule ForensicTest do
  use ExUnit.Case
  doctest Forensic

  test "basic sanity test" do
    assert Forensic.error(:test) == {:error, {ForensicTest, "test basic sanity test/1", [], :test}}
  end
end
