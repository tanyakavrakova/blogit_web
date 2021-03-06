defmodule BlogitWeb do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(BlogitWeb.Endpoint, [])
    ]

    opts = [strategy: :one_for_one, name: BlogitWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    BlogitWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
