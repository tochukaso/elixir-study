defmodule Rest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
 alias RestWeb.MovieEts

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RestWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Rest.PubSub},
      # Start the Endpoint (http/https)
      RestWeb.Endpoint
      # Start a worker by calling: Rest.Worker.start_link(arg)
      # {Rest.Worker, arg}
    ]

    # 映画のETSの初期化
    MovieEts.initialize()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
