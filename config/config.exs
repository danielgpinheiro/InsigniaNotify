import Config

config :insignia_notify, :environment, Mix.env()
config :insignia_notify, :ntfy_token, System.fetch_env("NTFY_TOKEN")
