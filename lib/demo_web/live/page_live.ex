defmodule DemoWeb.PageLive do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, number: 0, adding_amount: 0)}
  end

  def render(assigns) do
    ~H"""
    <%= @number %>
    <.button phx-click="add">Add</.button>

    <.form let={f} for={:adding_form} phx-submit="adding_by" phx-change="change_amount_by">
      <.input field={{f, :add_amount}} value={@adding_amount} />
      <.button>More</.button>
    </.form>
    """
  end

  def handle_event("add", _params, socket) do
    {:noreply, assign(socket, number: socket.assigns.number + 1)}
  end

  def handle_event("adding_by", %{"adding_form" => %{"add_amount" => the_added_amount}}, socket) do

    amount_to_add_by = case Integer.parse(the_added_amount) do
      {number, _} -> number
      :error -> 0
    end

    {:noreply, assign(socket, number: socket.assigns.number + amount_to_add_by)}
  end

  def handle_event("change_amount_by", %{"adding_form" => %{"add_amount" => adding_amount}}, socket) do
    {:noreply, assign(socket, adding_amount: adding_amount)}
  end

end
