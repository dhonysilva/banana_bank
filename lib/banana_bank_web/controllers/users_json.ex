defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created successfully.",
      data: data(user)
    }
  end

  def delete(%{user: user}), do: %{message: "User deleted successfully.", data: data(user)}
  def get(%{user: user}), do: %{data: data(user)}
  def update(%{user: user}), do: %{message: "User updated successfully.", data: data(user)}

  defp data(%User{} = user) do
    %{
      id: user.id,
      cep: user.cep,
      email: user.email,
      name: user.name
    }
  end
end
