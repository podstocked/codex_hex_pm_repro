defmodule CodexHexPmRepro.Repo do
  use Ecto.Repo,
    otp_app: :codex_hex_pm_repro,
    adapter: Ecto.Adapters.Postgres
end
