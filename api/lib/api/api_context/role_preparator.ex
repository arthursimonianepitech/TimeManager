defmodule RolePreparator do
  import Logger, only: [debug: 1]
  alias Api.ApiContext
  alias Api.ApiContext.Role

  # Crete The Roles if it doesn't exist
  def prepare do
    create_role_if_not_exist("admin")
    create_role_if_not_exist("user")
    create_role_if_not_exist("group")
  end

  def create_role_if_not_exist(role_name) do
    if is_nil(ApiContext.get_role_by_name(role_name)) do
      ApiContext.create_role(%{"name" => role_name})
    end
  end
end
