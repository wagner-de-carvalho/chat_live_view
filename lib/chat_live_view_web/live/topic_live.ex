defmodule ChatLiveViewWeb.TopicLive do
  use ChatLiveViewWeb, :live_view

  def mount(%{"topic_name" => topic_name} = _params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}), topic_name: topic_name)}
  end
end
