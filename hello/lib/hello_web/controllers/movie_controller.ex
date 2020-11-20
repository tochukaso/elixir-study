defmodule HelloWeb.MovieController do
  use HelloWeb, :controller

  alias HelloWeb.MovieEts
  alias HelloWeb.Entity.Movie

  require Logger

  def index(conn, _params) do
    Logger.info("called index")
    render_index(conn)
  end

  def show(conn, %{"title" => title}) do
    Logger.info("called show")
    result = MovieEts.read(title)
    IO.inspect(result, label: "result")

    if result == nil do
      render(conn, "index.html")
    else
      movie =
        result
        |> hd()
        |> elem(1)

      changeset =
        %Movie{}
        |> Movie.changeset(movie)

      render(conn, "detail.html", changeset: changeset, action: :update)
    end
  end

  def new(conn, _params) do
    Logger.info("called new")
    changeset = Movie.changeset(%Movie{}, %{:title => ""})

    render(conn, "detail.html", changeset: changeset, action: :create)
  end

  def create(conn, %{"movie" => params}) do
    Logger.info("called create")
    IO.inspect(params, label: "create params")
    changeset = put_movie(params)
    render(conn, "detail.html", changeset: changeset, action: :update)
  end

  def update(conn, %{"movie" => params}) do
    Logger.info("called update")
    IO.inspect(params, label: "update params")
    changeset = put_movie(params)
    render(conn, "detail.html", changeset: changeset, action: :update)
  end

  def delete(conn, %{"title" => title}) do
    Logger.info("called delete")
    MovieEts.delete(title)
    render_index(conn)
  end

  defp render_index(conn) do
    movies =
      MovieEts.read_all()
      |> Enum.map(fn {_, movie} ->
        movie
      end)

    render(conn, "index.html", movies: movies)
  end

  defp put_movie(params) do
    changeset = Movie.changeset(%Movie{}, params)
    changes = changeset.changes

    changes[:title]
    |> MovieEts.put(changes)

    changeset
  end
end
