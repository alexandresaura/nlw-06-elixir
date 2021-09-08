defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "alexandre@gmail.com", name: "Alexandre", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "alexandre@gmail.com",
            "id" => user_id,
            "name" => "Alexandre"
          }
        }
      }

      assert expected_response === response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Alexandre", email: "saura@alexandre.com", password: "123456"
          }) {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "createUser" => %{
            "email" => "saura@alexandre.com",
            "name" => "Alexandre"
          }
        }
      }

      assert expected_response === response
    end
  end
end
