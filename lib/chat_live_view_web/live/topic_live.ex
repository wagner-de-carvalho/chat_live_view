defmodule ChatLiveViewWeb.TopicLive do
  use ChatLiveViewWeb, :live_view

  def mount(%{"topic_name" => topic_name} = _params, _session, socket) do
    username = AnonymousNameGenerator.generate_random()
    {:ok, assign(socket, form: to_form(%{}), topic_name: topic_name, username: username)}
  end
end
