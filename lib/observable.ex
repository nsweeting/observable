defmodule Observable do
  @callback handle_notify({atom, any}) :: any

  def observer do
    quote do
      @behaviour Observable

      def handle_notify(_notification) do
        :ok
      end

      defoverridable Observable
    end
  end

  def notifier do
    quote do
      import Observable, only: [observations: 1]

      Module.register_attribute(__MODULE__, :observations, accumulate: true)
    end
  end

  def notify([struct | _] = data, action) when is_map(struct) do
    module = struct.__struct__
    notify(module, action, data)
  end

  def notify(struct, action) when is_map(struct) do
    module = struct.__struct__
    notify(module, action, struct)
  end

  def notify(module, action, data) do
    for observer <- module.__observations__(action) do
      apply(observer, :handle_notify, [{action, data}])
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro observations(do: block) do
    quote do
      @before_compile Observable

      try do
        import Observable
        unquote(block)
      after
        :ok
      end
    end
  end

  defmacro on_action(action, observer) do
    quote do
      Module.put_attribute(__MODULE__, :observations, {unquote(action), unquote(observer)})
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def __observations__ do
        @observations
      end

      def __observations__(action_to_find) do
        Enum.reduce(@observations, [], fn {action, observer}, observers ->
          if action_to_find == action, do: [observer | observers], else: observers
        end)
      end
    end
  end
end
