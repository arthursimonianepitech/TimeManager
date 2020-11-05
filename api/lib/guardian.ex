defmodule Api.Guardian do
  use Guardian, otp_app: :api

  def subject_for_token(users, _claims) do
    sub = to_string(users.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Api.ApiContext.get_users!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
