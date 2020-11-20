defmodule HelloWeb.MovieEts do
  @moduledoc """
  映画の情報を管理するためのテーブル
  """
  @moduledoc since: "0.0.1"

  @table :movie

  @doc """
  映画のテーブルを初期化します
  """
  @spec initialize() :: no_return()
  def initialize do
    :ets.new(@table, [:public, :named_table])
  end

  @doc """
  映画のテーブルにレコードを登録/更新します
  """
  @spec put(String.t(), map) :: map()
  def put(key, data) do
    :ets.insert(@table, {key, data})
  end

  @doc """
  映画のテーブルから特定のキーに合致するデータを取得します。
  """
  @spec read(String.t()) :: map()
  def read(key) do
    :ets.lookup(@table, key)
  end

  @doc """
  映画のテーブルから全データを取得します
  """
  @spec read_all() :: map()
  def read_all do
    :ets.tab2list(@table)
  end

  @doc """
  映画のテーブルからデータを削除します
  """
  @spec delete(String.t()) :: map()
  def delete(key) do
    :ets.delete(@table, key)
  end
end
