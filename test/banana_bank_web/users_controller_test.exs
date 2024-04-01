defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  alias BananaBank.Users
  alias Users.User

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      params = %{
        name: "João",
        cep: "12345678",
        email: "joao@gmail.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{"data" => %{"cep" => "12345678", "email" => "joao@gmail.com", "id" => _id , "name" => "João"}, "message" => "User created successfully."} = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        name: nil,
        cep: "12",
        email: "joao@gmail.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      expected_reponse = %{"errors" => %{"name" => ["can't be blank"]}}

      assert response == expected_reponse
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn} do
      params = %{
        name: "João",
        cep: "12345678",
        email: "joao@gmail.com",
        password: "123456"
      }

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}")
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"cep" => "12345678", "email" => "joao@gmail.com", "id" => id, "name" => "João"},
        "message" => "User deleted successfully."
      }

      assert response == expected_response
    end
  end
end
