defmodule ViewPreparator do
  import Logger, only: [debug: 1]
  alias Api.ApiContext

  # Crete The View working_time_view if it doesn't exist
  def prepare do
    ApiContext.create_view_if_not_exists()
  end

end
