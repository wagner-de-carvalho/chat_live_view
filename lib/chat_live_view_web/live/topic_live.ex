defmodule ChatLiveViewWeb.TopicLive do
  use ChatLiveViewWeb, :live_view

  def mount(params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}))}
  end
end
