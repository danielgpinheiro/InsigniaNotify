defmodule InsigniaNotify.Http.Api do
  alias InsigniaNotify.Http.HandleResponse

  def get(base_url) do
    case HTTPoison.get(base_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        HandleResponse.response(:ok, body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        HandleResponse.response(:error, :not_found)

      {:error, %HTTPoison.Error{reason: reason}} ->
        HandleResponse.response(:error, reason)
    end
  end

  def post(base_url, body, options) do
    case HTTPoison.post(base_url, body, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        HandleResponse.response(:ok, body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        HandleResponse.response(:error, reason)
    end
  end
end
