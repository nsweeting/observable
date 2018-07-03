defmodule Observable.TestObserver do
  defmacro __using__(_opts) do
    quote do
      use Observable, :observer

      def handle_notify({action, data}) do
        send(self(), {__MODULE__, action, data})
      end
    end
  end
end

defmodule Observable.TestObserverOne do
  use Observable.TestObserver
end

defmodule Observable.TestObserverTwo do
  use Observable.TestObserver
end
