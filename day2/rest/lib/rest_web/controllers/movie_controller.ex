defmodule RestWeb.MovieController do
  use RestWeb, :controller

  alias RestWeb.MovieEts
  alias RestWeb.Entity.Movie

  require Logger

  def index(conn, _params) do
    Logger.info("called index")
    get_all_movie()
    |> success(conn)
  end

  def create(conn, params) do
    Logger.info("called create")
    IO.inspect(params, label: "create params")
    put_movie(params)
    success(conn)
  end

  def read(conn, %{"title" => title}) do
    Logger.info("called show")
    result = MovieEts.read(title)
    IO.inspect(result, label: "result")

    if result == nil or result == [] do
      success(conn)
    else
      movie =
        result
        |> hd()
        |> elem(1)

      changeset =
        %Movie{}
        |> Movie.changeset(movie)

      success(changeset.changes, conn)
    end
  end

  def update(conn, params) do
    Logger.info("called update")
    IO.inspect(params, label: "update params")
    put_movie(params)
    |> success(conn)
  end

  def delete(conn, %{"title" => title}) do
    Logger.info("called delete")
    MovieEts.delete(title)
    success(conn)
  end

  defp get_all_movie() do
      MovieEts.read_all()
      |> Enum.map(fn {_, movie} ->
        movie
      end)
  end

  defp put_movie(params) do
    changeset = Movie.changeset(%Movie{}, params)
    changes = changeset.changes

    changes[:title]
    |> MovieEts.put(changes)

    changeset.changes
  end
end
