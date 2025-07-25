defmodule CodexHexPmRepro.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CodexHexPmReproWeb.Telemetry,
      CodexHexPmRepro.Repo,
      {DNSCluster, query: Application.get_env(:codex_hex_pm_repro, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CodexHexPmRepro.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CodexHexPmRepro.Finch},
      # Start a worker by calling: CodexHexPmRepro.Worker.start_link(arg)
      # {CodexHexPmRepro.Worker, arg},
      # Start to serve requests, typically the last entry
      CodexHexPmReproWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CodexHexPmRepro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CodexHexPmReproWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
