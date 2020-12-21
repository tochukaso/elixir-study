defmodule RestWeb.Plug.ApiSpec do

  alias OpenApiSpex.{OpenApi, OpenApi.Decode}

  @yaml_file_path "openapi.yaml"
  @yaml_file_dir "static/openapi"

  @behaviour OpenApi

  @doc """
  openapi.yamlファイルを読み取り、`map` でspecを提供する
  """
  @impl OpenApi
  def spec do
  "#{:code.priv_dir(:rest)}/#{@yaml_file_dir}/#{@yaml_file_path}"
  |> YamlElixir.read_all_from_file!()
  |> List.first()
  |> Decode.decode()
  end

end
