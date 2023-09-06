defmodule InsigniaNotify.Http.GetHTML do
  alias InsigniaNotify.Http.Api

  def get_insignia_data(insignia_url) do
    Api.get(insignia_url)
  end
end
