defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view
  alias Pento.Account
  def mount(_params, session, socket) do
    {:ok, assign(socket,
    score: 0,
    message: "Make a guess: ",
    win: false,
    session_id: session["live_socket_id"],
    )}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
      <h2> <%= @message %> </h2>
        <br/>

    <%= if @win == true do %>
      <.link class="bg-blue-500 hover:bg-blue-700
            text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
            patch={~p"/guess"} >
              Restart
            </.link>
    <% else %>
    <h2>
      <%= for n <- 1..10 do %>
      <.link class="bg-blue-500 hover:bg-blue-700
            text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
            phx-click="guess" phx-value-number= {n} >
              <%= n %>
            </.link>
          <% end %>
        </h2>
    <% end %>
    <br/>
    <pre>
      <%= @session_id %>
      <%= @current_user.email %>
    </pre>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {guess, _} = Integer.parse(guess)
    val = :rand.uniform(10)
    case val do
      ^guess -> {:noreply, assign(socket, score: socket.assigns.score + 9, message: "#{val} Correct! Play again", win: true)}
      _ -> {:noreply, assign(socket, score: socket.assigns.score - 1, message: "#{val} Wrong, try again:", win: false)}
    end
  end

  def handle_params(_params, _uri, socket) do
      {:noreply, assign(socket, message: "Make a guess:", win: false)}
    end
end
