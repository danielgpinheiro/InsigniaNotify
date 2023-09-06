defmodule InsigniaNotify.Http.CreateNotification do
  alias InsigniaNotify.Http.Api

  def create(params) do
    notify_body(params)
    |> push_notification()
  end

  defp notify_body(params) do
    game = Map.get(params, :game)
    new_session = Map.get(params, :new_session)

    game_name = Map.get(game, :name)
    game_url = Map.get(game, :url)
    game_serial = Map.get(game, :serial)
    game_active_players = Map.get(game, :active_players)
    game_active_sessions = Map.get(game, :active_sessions)

    new_session_message =
      "#{game_name} (#{game_serial}) has #{game_active_players} active players and #{game_active_sessions} sessions now"

    no_session_message = "#{game_name} (#{game_serial}) no longer has active sessions"

    IO.puts(
      "Push Notification #{game_name} (#{game_serial}) - Players: #{game_active_players} - New Session: #{new_session}"
    )

    body = %{
      topic: "insignia_notify",
      message:
        if(new_session,
          do: new_session_message,
          else: no_session_message
        ),
      title:
        if(new_session,
          do: "New game session in Insignia",
          else: "No more game session in this game"
        ),
      tags: [
        if(new_session, do: "new", else: "no_entry_sign"),
        "video_game"
      ],
      priority: 4,
      click:
        if(new_session,
          do: game_url,
          else: "https://insignia.live"
        )
    }

    {:ok, body}
  end

  def push_notification({:ok, _}) do
    # def push_notification({:ok, body}) do
    req_body =
      Poison.encode!(%{
        topic: "insignia_notify_test",
        message: "Project Gotham Racing 2 has 3 active players and 5 sessions now",
        title: "New game session in Insignia",
        tags: [
          "new",
          "video_game"
        ],
        priority: 4,
        click: "https://insignia.live/#games"
      })

    # req_body = Poison.encode!(body)
    {_, token} = Application.get_env(:insignia_notify, :ntfy_token)
    base_url = "http://ntfy.sh"
    headers = [Authorization: "Bearer #{token}", "Content-Type": "application/json"]

    Api.post(base_url, req_body, headers)
  end
end
