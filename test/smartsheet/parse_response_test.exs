defmodule Smartsheet.ParseResponseTest do
  use ExUnit.Case

  alias Smartsheet.MockClient.ResponseFixtures
  alias Smartsheet.ParseResponse

  describe "Smartsheet.Sheets" do
    test ":get success" do
      {:ok, raw_http_response} = ResponseFixtures.get_sheet_success()
      wrapped_response = ParseResponse.parse(Smartsheet.Sheets, {:get, 1}, raw_http_response)

      assert {:ok, %Smartsheet.Response{}, sheet = %Smartsheet.Sheet{}} = wrapped_response

      sheet.columns
      |> Enum.each(fn column ->
        assert %Smartsheet.Column{} = column
      end)
    end

    test ":get failure" do
      {:ok, raw_http_response} = ResponseFixtures.get_sheet_failure()
      wrapped_response = ParseResponse.parse(Smartsheet.Sheets, {:get, 1}, raw_http_response)

      assert {:error, %Smartsheet.Response{}} = wrapped_response
    end

    test ":create success" do
      {:ok, raw_http_response} = ResponseFixtures.create_sheet_success()
      wrapped_response = ParseResponse.parse(Smartsheet.Sheets, {:create, 1}, raw_http_response)

      assert {:ok, %Smartsheet.Response{}, sheet = %Smartsheet.Sheet{}} = wrapped_response

      sheet.columns
      |> Enum.each(fn column ->
        assert %Smartsheet.Column{} = column
      end)
    end

    test ":create failure" do
      {:ok, raw_http_response} = ResponseFixtures.create_sheet_failure()
      wrapped_response = ParseResponse.parse(Smartsheet.Sheets, {:create, 1}, raw_http_response)

      assert {:error, %Smartsheet.Response{}} = wrapped_response
    end
  end

  describe "Smartsheet.Rows" do
    test ":add_to_sheet success" do
      {:ok, raw_http_response} = ResponseFixtures.add_rows_success()

      wrapped_response =
        ParseResponse.parse(Smartsheet.Rows, {:add_to_sheet, 1}, raw_http_response)

      assert {:ok, %Smartsheet.Response{}, rows} = wrapped_response

      rows
      |> Enum.each(fn row ->
        assert %Smartsheet.Row{} = row
      end)
    end

    test ":add_to_sheet failure" do
      {:ok, raw_http_response} = ResponseFixtures.add_rows_failure()

      wrapped_response =
        ParseResponse.parse(Smartsheet.Rows, {:add_to_sheet, 1}, raw_http_response)

      assert {:error, %Smartsheet.Response{}} = wrapped_response
    end
  end
end