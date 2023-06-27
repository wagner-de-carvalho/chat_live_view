defmodule ChatLiveViewWeb.TopicLive do
  @moduledoc false
  use ChatLiveViewWeb, :live_view
  alias ChatLiveViewWeb.Endpoint
  alias ChatLiveViewWeb.Presence
  alias ChatLiveViewWeb.Topics.Topic

  def mount(%{"topic_name" => topic_name} = _params, _session, socket) do
    username = AnonymousNameGenerator.generate_random()

    if connected?(socket) do
      Endpoint.subscribe(topic_name)
      Presence.track(self(), topic_name, username, %{})
    end

    {:ok,
     assign(socket,
       form: to_form(%{}),
       topic_name: topic_name,
       username: username,
       message: "",
       chat_messages: [],
       temporary_assigns: [chat_messages: []],
       users_online: []
     )}
  end

  def handle_event("submit_message", %{"message" => message}, socket) do
    message_data = %{msg: message, username: socket.assigns.username, uuid: UUID.uuid4()}

    Endpoint.broadcast(socket.assigns.topic_name, Topic.set_topic(:new_message), message_data)

    {:noreply, assign(socket, message: message)}
  end

  def handle_event("message_change", %{"message" => message}, socket) do
    valid_message = String.trim(message)
    {:noreply, assign(socket, message: valid_message)}
  end

  def handle_info(%{event: "new_message", payload: message_data}, socket) do
    {:noreply, assign(socket, chat_messages: [message_data])}
  end

  def handle_info(%{event: "presence_diff"}, socket) do
    users_online =
      Presence.list(socket.assigns.topic_name)
      |> Map.keys()
      |> Enum.with_index(1)

    {:noreply, assign(socket, users_online: users_online)}
  end

  def user_msg_heex(assigns) do
    ~H"""
    <li
      id={@msg_data.uuid}
      class={"relative #{if @msg_data.username == @me, do: "bg-white ml-40", else: "bg-green-300 mr-40"} mb-2 py-5 px-4 border rounded-sm"}
    >
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
