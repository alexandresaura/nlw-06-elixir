defmodule Wabanex.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wabanex.Training

  @fields [:name, :youtube_video_url, :protocol_description, :repetitions]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "exercises" do
    field :name, :string
    field :youtube_video_url, :string
    field :protocol_description, :string
    field :repetitions, :string

    belongs_to :training, Training

    timestamps()
  end

  def changeset(exercise \\ %__MODULE__{}, params \\ %{}) do
    exercise
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
