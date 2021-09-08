defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Alexandre", email: "alexandre@banana.com", password: "123456"}

      response = User.changeset(%User{}, params)

      assert %Ecto.Changeset{
               changes: %{email: "alexandre@banana.com", name: "Alexandre", password: "123456"},
               valid?: true,
               errors: []
             } = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "A", email: "alexandre@banana.com"}

      response = User.changeset(%User{}, params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert expected_response === errors_on(response)
    end
  end
end
