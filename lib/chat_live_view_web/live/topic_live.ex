defmodule ChatLiveViewWeb.TopicLive do
  use ChatLiveViewWeb, :live_view

  def mount(%{"topic_name" => topic_name} = _params, _session, socket) do
    username = AnonymousNameGenerator.generate_random()

    {:ok,
     assign(socket, form: to_form(%{}), topic_name: topic_name, username: username, message: "")}
  end

  def handle_event("submit_message", %{"message" => message}, socket) do
    {:noreply, assign(socket, message: message)}
  end

  def handle_event("message_change", %{"message" => message}, socket) do
    valid_message = String.trim(message)
    {:noreply, assign(socket, message: valid_message)}
  end
end
