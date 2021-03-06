defmodule Theme01Web.Router do
  use Theme01Web, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", Theme01Web do
    pipe_through :api

    resources("/users", UsersController)
    post("/users", UserController, :create)
    get("/users/:id",  UsersController, :show)
    put("/users/:id", UsersController, :update)
    delete("/users/:id", UsersController, :delete)

    resources("/workingtimes", WorkingTimesController)
    post("/workingtimes/:userID", WorkingTimesController, :create)

    get("/workingtimes/:userID/:workingtimeID", WorkingTimesController, :show)
    get("/workingtimes/:userID", WorkingTimesController, :show)
    get("/workingtimes", WorkingTimesController, :index)

    put("/workingtimes/:id", WorkingTimesController, :update)
    delete("/workingtimes/:id", WorkingTimesController, :delete)

    resources("/clocks", ClocksController)
    get("/clocks/:userID", ClocksController, :show)
    post("/clocks/:userID", ClocksController, :create)

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
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: Theme01Web.Telemetry
    end
  end
end
