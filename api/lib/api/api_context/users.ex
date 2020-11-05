defmodule Api.ApiContext.Users do
  use Ecto.Schema
  import Ecto.Changeset
  import Bcrypt

  schema "users" do
    field(:email, :string)
    field(:username, :string)
    field(:role, :id)
    field(:password_hash, :string)

    # Virtual fields: Never saved
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    # Remove hash, add pw + pw confirmation
    |> cast(attrs, [:username, :email, :password, :password_confirmation])
    # Remove hash, add pw + pw confirmation
    |> validate_required([:username, :email, :password, :password_confirmation])
    # Check that email is valid
    |> validate_format(:email, ~r/^[A-Za-z0-9\._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]/)
    # Check that password length is >= 8
    |> validate_length(:password, min: 8, message: "Must be at least 8 character long")
    # Check that password is strong
    |> validate_format(:password, ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*/,
      message: "Must include at least one lowercase letter, one uppercase letter, and one digit"
    )
    # Check that password === password_confirmation
    |> validate_confirmation(:password)
    # Check password is unique
    |> unique_constraint(:email)
    # Add put_password_hash to changeset pipeline
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
