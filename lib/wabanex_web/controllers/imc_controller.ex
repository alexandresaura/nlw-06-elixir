defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_reponse(conn)
  end

  defp handle_reponse({:ok, result}, conn), do: render_response(:ok, result, conn)

  defp handle_reponse({:error, reason}, conn), do: render_response(:bad_request, reason, conn)

  defp render_response(status, response, conn) do
    conn
    |> put_status(status)
    |> json(%{response: response})
  end
end
