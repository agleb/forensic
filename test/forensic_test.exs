defmodule ForensicTest do
  use ExUnit.Case
  doctest Forensic

  test "basic sanity test" do
    assert Forensic.error(:test) == {:error, {ForensicTest, "test basic sanity test/1", [], :test}}
  end

  test "attach an error to the history" do
    assert Forensic.attach({:error,[{1,2,3,4}]}) ==  {:error,
    [
      {ForensicTest, "test attach an error to the history/1", []},
      {1, 2, 3, 4}
    ]}
    assert Forensic.attach({:error,{1,2,3,4}}) ==  {:error,
    [
      {ForensicTest, "test attach an error to the history/1", []},
      {1, 2, 3, 4}
    ]}
    assert Forensic.attach({1,2,3,4}) ==  {:error,
    [
      {ForensicTest, "test attach an error to the history/1", []},
      {1, 2, 3, 4}
    ]}
  end


end
