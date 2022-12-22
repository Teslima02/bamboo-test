defmodule BambooWeb.PageController do
  use BambooWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
