defmodule ChatLiveViewWeb.HomeLive do
  use ChatLiveViewWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: :changeset))}
  end

  def handle_event("goto_topic", %{"topic_name" => topic_name}, socket) do
    topic_link = "/" <> topic_name
    {:noreply, push_navigate(socket, to: topic_link)}
  end
end
