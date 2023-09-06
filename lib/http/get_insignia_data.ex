defmodule InsigniaNotify.Http.GetInsigniaData do
  alias InsigniaNotify.Http.Api

  def get(insignia_url) do
    Api.get(insignia_url)
  end
end
