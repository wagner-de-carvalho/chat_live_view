defmodule ChatLiveView.Repo do
  use Ecto.Repo,
    otp_app: :chat_live_view,
    adapter: Ecto.Adapters.Postgres
end
