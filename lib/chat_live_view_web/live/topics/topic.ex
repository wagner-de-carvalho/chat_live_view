defmodule ChatLiveViewWeb.Topics.Topic do
  @moduledoc false

  @topics [{:new_message, "new_message"}, {:random, "random"}, {:unknown, "unknown"}]

  @spec set_topic(atom()) :: String.t()
  def set_topic(topic_name), do: Keyword.get(@topics, topic_name, "random")
end
