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
     assign(socket,
       form: to_form(%{}),
       topic_name: topic_name,
       username: username,
       message: "",
       chat_messages: []
     )}
  end

  def handle_event("submit_message", %{"message" => message}, socket) do
    message_data = %{msg: message, username: socket.assigns.username}

    Endpoint.broadcast(socket.assigns.topic_name, Topic.set_topic(:new_message), message_data)

    {:noreply, assign(socket, message: message)}
  end

  def handle_event("message_change", %{"message" => message}, socket) do
    valid_message = String.trim(message)
    {:noreply, assign(socket, message: valid_message)}
  end

  def handle_info(%{event: "new_message", payload: message_data}, socket) do
    message_data = socket.assigns.chat_messages ++ [message_data]
    {:noreply, assign(socket, chat_messages: message_data)}
  end

  def user_msg_heex(assigns) do
    ~H"""
    <li class="relative bg-white py-5 px-4 focus-within:ring-2 focus-within:ring-inset focus-within:ring-indigo-600 hover:bg-gray-50">
      <div class="flex justify-between space-x-3">
        <div class="min-w-0 flex-1">
          <a href="#" class="block focus:outline-none">
            <span class="absolute inset-0" aria-hidden="true"></span>
            <p class="truncate text-sm font-medium text-gray-900 mb-4"><%= @msg_data.username %></p>
          </a>
        </div>
      </div>
      <div class="mt-1">
        <p class="text-sm text-gray-600 line-clamp-2">
          <%= @msg_data.msg %>
        </p>
      </div>
    </li>
    """
  end
end
