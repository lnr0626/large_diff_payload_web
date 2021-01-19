defmodule LargeDiffPayloadWeb.PodcastLive do
  use LargeDiffPayloadWeb, :live_view

  # for some randomness on page load
  defmodule StringGenerator do
    @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" |> String.split("")
    @chars_with_spaces [" " | @chars]

    def string_of_length(length, opts \\ []) do
      alphabet = if opts[:spaces], do: @chars_with_spaces, else: @chars

      Enum.reduce(1..length, [], fn _i, acc ->
        [Enum.random(alphabet) | acc]
      end)
      |> Enum.join("")
    end
  end

  alias LargeDiffPayloadWeb.Components.PodcastDetailsPage
  alias LargeDiffPayload.{Podcast, Feed, Episode}

  @impl true
  def mount(%{"podcast_id" => podcast_id}, _session, socket) do
    {:ok, assign_podcast(socket, podcast_id)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <%= if @podcast do %>
      <%= live_component(@socket, PodcastDetailsPage, podcast: @podcast, change_event: "podcast_change", change_event_target: "live_view") %>
    <% end %>
    """
  end

  @impl true
  def handle_event("podcast_change", %{"podcast" => params}, socket) do
    {:noreply, update_podcast(socket, params)}
  end

  defp assign_podcast(socket, podcast_id) do
    podcast = %Podcast{
      id: podcast_id,
      title: "The one true podcast #{StringGenerator.string_of_length(4)}",
      description:
        "Some text about the pod cast....but wait, there's some randomness!! #{
          StringGenerator.string_of_length(40, spaces: true)
        }",
      is_feed_public: false,
      feeds: Stream.repeatedly(&new_feed/0) |> Enum.take(:random.uniform(3)),
      episodes: Stream.repeatedly(&new_episode/0) |> Enum.take(:random.uniform(10))
    }

    assign(socket, :podcast, podcast)
  end

  defp update_podcast(socket, params) do
    assign(socket, :podcast, %{socket.assigns.podcast | is_feed_public: params["is_feed_public"]})
  end

  defp new_feed() do
    %Feed{
      url: "https://example.org/#{StringGenerator.string_of_length(20)}",
      title: "Feed Name #{StringGenerator.string_of_length(10, spaces: true)}"
    }
  end

  defp new_episode() do
    %Episode{
      title: "Episode Name #{StringGenerator.string_of_length(10, spaces: true)}"
    }
  end
end
