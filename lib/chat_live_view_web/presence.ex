defmodule ChatLiveViewWeb.Presence do
  use Phoenix.Presence,
    otp_app: :chat_live_view,
    pubsub_server: ChatLiveView.PubSub
end
