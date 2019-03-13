defmodule ForensicTest do
  use ExUnit.Case
  require Forensic

  test "basic sanity test" do
    assert {:error, %Forensic.Errors{history: [%Forensic.Error{contents: :test}]}} =
             Forensic.error(:test)
  end

  test "{:error, error} detection" do
    assert {:error, %Forensic.Errors{history: [%Forensic.Error{contents: :test}]}} =
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
end
