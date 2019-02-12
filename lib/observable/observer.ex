defmodule Observable.Observer do
  @moduledoc false

  @callback handle_notify(Observable.action(), Observable.data()) :: Observable.result()

  @doc false
  def macro do
    quote do
      @behaviour Observable.Observer

      def handle_notify(_action, _data) do
        :ok
      end

      defoverridable Observable.Observer
    end
  end
end
