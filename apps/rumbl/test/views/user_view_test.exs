defmodule Rumbl.UserViewTest do
  use Rumbl.ConnCase, async: true
  import Phoenix.View
  alias Rumbl.User
  alias Rumbl.UserView

  test "renders index.html", %{conn: conn} do
    users = [
      %User{id: 123, name: "Peter Parker", username: "p.parker"},
      %User{id: 456, name: "Bruce Wayne", username: "b.wayne"}
    ]
    content = render_to_string(UserView, "index.html", conn: conn, users: users)

    assert String.contains?(content, "Listing users")
    for user <- users do
      assert String.contains?(content, to_string(user.id))
    end
  end
end
