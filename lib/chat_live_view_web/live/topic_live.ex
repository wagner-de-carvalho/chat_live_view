defmodule ChatLiveViewWeb.TopicLive do
  @moduledoc false
  use ChatLiveViewWeb, :live_view
  alias ChatLiveViewWeb.Endpoint
  alias ChatLiveViewWeb.Topics.Topic

  def mount(%{"topic_name" => topic_name} = _params, _session, socket) do
    username = AnonymousNameGenerator.generate_random()

    if connected?(socket) do
      Endpoint.subscribe(topic_name)
    end

    {:ok,
     assign(socket, form: to_form(%{}), topic_name: topic_name, username: username, message: "")}
  end

  def handle_event("submit_message", %{"message" => message}, socket) do
    Endpoint.broadcast(socket.assigns.topic_name, Topic.set_topic(:new_message), message)
    {:noreply, assign(socket, message: message)}
  end

  def handle_event("message_change", %{"message" => message}, socket) do
    valid_message = String.trim(message)
    {:noreply, assign(socket, message: valid_message)}
  end

  def handle_info(%{event: "new_message", payload: message_data}, socket) do
    {:noreply, socket}
  end
end
