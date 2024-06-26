defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
  end

  def discount_changeset(product, discounted_price) do
    product
    |> cast(%{unit_price: discounted_price}, [:unit_price])
    |> validate_required([:unit_price])
    |> validate_discount_price()
  end

  def validate_discount_price(changeset) do
    current_price = changeset.data().unit_price

    changeset
    |> validate_number(:unit_price,
      less_than: current_price,
      message: "discounted price must be less than current price"
    )
  end
end
