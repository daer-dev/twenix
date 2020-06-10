defmodule AppWeb.PostLive.PostComponent do
  use AppWeb, :live_component

  def render(assigns) do
    ~L"""
      <tr id="post-<%= @post.id %>">
        <td><%= @post.username %></td>
        <td><%= @post.body %></td>
        <td>
          <%= @post.likes_count %>
          <a href="#" phx-click="like" phx-target="<%= @myself %>">+</a>
        </td>
        <td>
          <%= @post.reposts_count %>
          <a href="#" phx-click="repost" phx-target="<%= @myself %>">+</a>
        </td>

        <td>
          <span><%= live_redirect "Show", to: Routes.post_show_path(@socket, :show, @post) %></span>
          <span><%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post) %></span>
          <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] %></span>
        </td>
      </tr>
    """
  end

  def handle_event("like", _, socket) do
    App.Timeline.increase_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    App.Timeline.increase_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
