defmodule NotableWeb.PageController do
  use NotableWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
