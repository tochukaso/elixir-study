defmodule RestWeb.Entity.Movie do
  @moduledoc """
  映画の情報を管理するためのオブジェクト
  """
  @moduledoc since: "0.0.1"

  use Ecto.Schema
  import Ecto
  import Ecto.Changeset

  @required_fields [:title]
  @optional_fields [:rate, :note]

  schema "movie" do
    field(:title, :string)
    field(:rate, :string)
    field(:note, :string)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> IO.inspect(label: "changeset result")
  end
end
