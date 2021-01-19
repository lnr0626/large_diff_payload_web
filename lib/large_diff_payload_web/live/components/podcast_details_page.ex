defmodule LargeDiffPayloadWeb.Components.PodcastDetailsPage do
  use LargeDiffPayloadWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <h2><%= @podcast.title %></h2>
    <p><%= @podcast.description %></p>

    <h3>Episodes</h3>
    <ul>
      <%= for episode <- @podcast.episodes do %>
      <li>
        <%= episode.title %>
      </li>
      <% end %>
    </ul>

    <h3>Feeds</h3>
    <ul>
      <%= for feed <- @podcast.feeds do %>
      <li>
        <%= feed.title || feed.url %>
      </li>
      <% end %>
    </ul>

    <%= f = form_for :podcast, "#", event_opts(@change_event, @change_event_target) %>
      <div>
        <%= label f, :is_feed_public, do: Phoenix.Naming.humanize(:is_feed_public) %>
        <%= checkbox f, :is_feed_public, checked: @podcast.is_feed_public %>
      </div>
    </form>
    """
  end

  defp event_opts(event, "live_view") do
    [phx_change: event]
  end

  defp event_opts(event, target) do
    [phx_change: event, phx_target: target]
  end
end
