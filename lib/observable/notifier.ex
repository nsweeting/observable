defmodule Observable.Notifier do
  def macro do
    quote do
      import Observable.Notifier, only: [observations: 1]

      Module.register_attribute(__MODULE__, :observations, accumulate: true)
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

      def __observations__(_) do
        []
      end
    end
  end

  defmacro action(action, observers) do
    quote do
      def __observations__(unquote(action)) do
        unquote(observers)
      end
    end
  end
end
