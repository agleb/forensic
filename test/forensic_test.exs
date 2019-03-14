defmodule ForensicTest do
  use ExUnit.Case
  import Forensic

  test "basic sanity test" do
    assert {:error, %Forensic.Errors{history: [%Forensic.Error{description: :test}]}} =
             Forensic.error(:test)
  end

  test "{:error, error} detection" do
    assert {:error, %Forensic.Errors{history: [%Forensic.Error{description: :test}]}} =
             Forensic.error({:error, :test})
  end

  test "Forensic.Errors protocol detection" do
    sequence =
      {:error, %Forensic.Errors{}}
      |> Forensic.error()
      |> Forensic.error()

    expected =
      {:error,
       %Forensic.Errors{
         history: [
           %Forensic.Error{
             bindings: [],
             contents: nil,
             description: :no_description,
             function: "test Forensic.Errors protocol detection/1",
             module: ForensicTest
           },
           %Forensic.Error{
             bindings: [],
             contents: nil,
             description: :no_description,
             function: "test Forensic.Errors protocol detection/1",
             module: ForensicTest
           }
         ]
       }}

    assert expected = sequence
  end

  test "error loopback filtering" do
    error = :it_is_here

    assert {:error,
            %Forensic.Errors{
              history: [
                %Forensic.Error{
                  bindings: [],
                  contents: :no_description,
                  description: :test,
                  function: "test error loopback filtering/1",
                  module: ForensicTest
                }
              ]
            }} == Forensic.error(:test)
  end

  test "last?(error_signature) pattern matching" do
    assert Forensic.last?(:test) = Forensic.error({:error, :test})
  end

  test "last?(error_signature) full-on scenario" do
    with {:ok, result} <- Forensic.error({:error, :test}) do
      {:ok, result}
    else
      Forensic.last?(:test) = error -> assert Forensic.last?(:test) = error
    end
  end
end
