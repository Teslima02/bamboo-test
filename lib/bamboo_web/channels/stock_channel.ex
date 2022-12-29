defmodule BambooWeb.StockChannel do
  use BambooWeb, :channel

  @impl true
  def join("stock:new_listed_stocks", _payload, socket) do
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (stock:new_listed_stocks).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  intercept ["shout"]
  @impl true
  def handle_out("shout", payload, socket) do
    push(socket, "shout", payload)

    {:noreply, socket}
  end

  @impl true
  def handle_out(event, payload, socket) do
    push(socket, event, payload)

    {:noreply, socket}
  end
end
