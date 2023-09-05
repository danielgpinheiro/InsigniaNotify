defmodule InsigniaNotify.HandleResponse do
  def response(:ok, params) do
    {:ok, params}
  end

  def response(:error, reason) do
    raise RuntimeError, message: "#{reason}"
  end
end
