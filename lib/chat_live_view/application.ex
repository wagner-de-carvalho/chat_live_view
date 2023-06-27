defmodule ChatLiveView.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ChatLiveViewWeb.Telemetry,
      # Start the Ecto repository
      # ChatLiveView.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ChatLiveView.PubSub},
      # ChatLiveViewWeb Presence
      ChatLiveViewWeb.Presence,
      # Start the Endpoint (http/https)
      ChatLiveViewWeb.Endpoint,
      # Start Finch
      {Finch, name: ChatLiveView.Finch}
      # Start a worker by calling: ChatLiveView.Worker.start_link(arg)
      # {ChatLiveView.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChatLiveView.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatLiveViewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
