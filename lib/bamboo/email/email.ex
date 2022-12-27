defmodule Bamboo.Email.Email do
  import Swoosh.Email

  def new_listed_stocks(user, stock) do
    new()
    |> to({user.name, user.email})
    |> from({"Mr Bamboo Investment", "bamboo@email.com"})
    |> subject("Our New Listed Stock")
    |> html_body("<h1>Hello #{user.name}</h1>")
    |> text_body(
      "Company name #{stock.name}\n Company symbol #{stock.symbol}\n Company address #{stock.address}\n Company country #{stock.country}\n"
    )
  end
end
