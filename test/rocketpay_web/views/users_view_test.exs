defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase

  import Phoenix.View

  alias Rocketpay.{User, Account}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "John Doe",
      password: "success",
      nickname: "john",
      email: "johndoe@test.com",
      age: 27
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{balance: Decimal.new("0.00"), id: account_id},
        id: user_id,
        name: "John Doe",
        nickname: "john"
      }
    }

    assert expected_response == response
  end
end
