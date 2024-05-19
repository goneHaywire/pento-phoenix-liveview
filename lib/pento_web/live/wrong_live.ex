defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def time() do
    DateTime.utc_now() |> to_string
  end

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     assign(socket, score: 0, message: "Make a guess:", session_id: session["live_socket_id"])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %> It's <%= time() %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end

  @impl true
  def handle_event("guess", %{"number" => guess}, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1

    {
      :noreply,
      assign(socket, message: message, score: score)
    }
  end
end
