defmodule Observable.Notifier do
  @moduledoc false

  @doc false
  def macro do
    quote do
      import Observable.Notifier, only: [observations: 1]

      Module.register_attribute(__MODULE__, :observers, accumulate: true)
    end
  end

  defmacro observations(do: block) do
    quote do
      try do
        import Observable.Notifier
        unquote(block)
      after
        :ok
      end

      def __observers__(_) do
        []
      end
    end
  end

  defmacro action(action, observers) do
    quote do
      def __observers__(unquote(action)) do
        unquote(observers)
      end
    end
  end
end
