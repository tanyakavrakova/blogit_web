defmodule BlogitWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :blogit_web

  socket "/socket", BlogitWeb.UserSocket

  plug Plug.Static,
    at: "/", from: :blogit_web, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  plug Plug.Static,
    at: "custom/",
    from: Blogit.GitRepository.local_path, gzip: false,
    only: [Application.get_env(:blogit, :assets_path, "assets")]

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_blogit_web_key",
    signing_salt: "b3V3v7Jq"

  plug BlogitWeb.Router
end
