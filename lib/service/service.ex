defmodule Grimoire.Service do
  @moduledoc """
  Create a new grimoire service
  """

  defmacro __using__(_opts) do
    quote do
      import Grimoire.Service
    end
  end

  defmacro service(name, do: block) do
    quote do
      defmodule Grimoire.Services.unquote(name) do
        use Plug.Router

        Module.register_attribute(__MODULE__, :schema, accumulate: false, persist: true)
        Module.register_attribute(__MODULE__, :route, accumulate: false, persist: true)

        unquote(block)

        # Encoding plug
        plug(Plug.Parsers,
          parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
          pass: ["*/*"],
          json_decoder: Jason
        )

        # Match and dispatch plugs
        plug(:match)
        plug(:dispatch)

        # Graphiql
        if Application.get_env(:grimoire, :graphiql, true) do
          forward("/graphiql",
            to: Absinthe.Plug.GraphiQL,
            init_opts: [schema: @schema]
          )
        end

        # Main graphql route
        forward("/",
          to: Absinthe.Plug,
          init_opts: [schema: @schema]
        )

        def schema do
          @schema
        end

        def route do
          @route
        end

        def init(options), do: options
      end
    end
  end

  defmacro schema(schema_field) do
    quote do
      @schema unquote(schema_field)
    end
  end

  defmacro route(path) when is_binary(path) do
    quote do
      @route unquote(path)
    end
  end
end
