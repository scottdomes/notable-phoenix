defmodule Notable.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset
  alias Notable.Notes.Note


  schema "notes" do
    field :body, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Note{} = note, attrs) do
    note
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
