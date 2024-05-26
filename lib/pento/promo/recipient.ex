defmodule Pento.Promo.Recipient do
  defstruct [:email, :first_name]
  @types %{email: :string, first_name: :string}

  import Ecto.Changeset

  def changeset(%__MODULE__{} = user, attrs) do
    {user, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:email, :first_name])
    |> validate_format(:email, ~r/@/)
  end
end
