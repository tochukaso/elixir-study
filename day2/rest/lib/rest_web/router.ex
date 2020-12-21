defmodule RestWeb.Router do
  use RestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RestWeb do
    pipe_through :api

    get "/v1/movies/", MovieController, :index
    post "/v1/movies/", MovieController, :create
    get "/v1/movies/:title", MovieController, :read
    put "/v1/movies/:title", MovieController, :update
    delete "/v1/movies/:title", MovieController, :delete
  end

  pipeline :openapi do
    plug(OpenApiSpex.Plug.PutApiSpec,
      module: RestWeb.Plug.ApiSpec
    )
  end

  # Other scopes may use custom stacks.
  # scope "/api", RestWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    pipe_through(:openapi)
    get("/openapi", OpenApiSpex.Plug.RenderSpec, [])
    import Phoenix.LiveDashboard.Router

    scope "/swagger" do
      get("/", OpenApiSpex.Plug.SwaggerUI, path: "/openapi")
    end

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: RestWeb.Telemetry
    end
  end

end
