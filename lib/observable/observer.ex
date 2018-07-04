defmodule Observable.Observer do
  @callback handle_notify({atom, any}) :: any

  def macro do
    quote do
      @behaviour Observable.Observer

      def handle_notify(_notification) do
        :ok
      end

      defoverridable Observable.Observer
    end
  end
end
