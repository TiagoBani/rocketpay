defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when call params are valid, returns an user" do
      params = %{
        name: "John Doe",
        password: "success",
        nickname: "john",
        email: "johndoe@test.com",
        age: 27
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{name: "John Doe", age: 27, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "",
        password: "",
        nickname: "john",
        email: "johndoe@test.com",
        age: 17
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        name: ["can't be blank"],
        password: ["can't be blank"]
      }

      assert expected_response == errors_on(changeset)
    end
  end
end
