defmodule ApiWeb.Router do
  use ApiWeb, :router
  alias Api.Guardian

  pipeline :api do
    plug(CORSPlug, origin: "*")
    plug(:accepts, ["json"])
  end

  pipeline :jwt_authenticated do
    plug(Api.Guardian.AuthPipeline)
  end

  scope "/api", ApiWeb do
    pipe_through(:api)

    post("/sign_up", UsersController, :create)
    post("/sign_in", UsersController, :sign_in)

    resources("/role", RoleController)
    get("/role", RoleController, :show)
    # TODO: Creer les roles seulement si on est admin
    # post("/role", RoleController, :create)
  end

  scope "/api", ApiWeb do
    pipe_through([:api, :jwt_authenticated])

    get("/users", UsersController, :show)
    put("/users", UsersController, :update)
    delete("/users", UsersController, :delete)

    get("/workingtimes", WorkingTimesController, :show)
    get("/workingtimes/:id", WorkingTimesController, :show)
    post("/workingtimes", WorkingTimesController, :create)
    put("/workingtimes/:id", WorkingTimesController, :update)
    delete("/workingtimes/:id", WorkingTimesController, :delete)

    get("/clocks", ClocksController, :show)
    get("/clocks/:id", ClocksController, :show)
    post("/clocks", ClocksController, :create)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: ApiWeb.Telemetry)
    end
  end
end
