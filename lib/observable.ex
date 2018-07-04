defmodule Observable do
  def notify([%_{} = struct | _] = data, action) do
    module = struct.__struct__
    notify(module, action, data)
  end

  def notify(%_{} = data, action) do
    module = data.__struct__
    notify(module, action, data)
  end

  def notify(module, action, data) do
    for observer <- module.__observations__(action) do
      apply(observer, :handle_notify, [{action, data}])
    end
  end

  defmacro __using__(:observer) do
    Observable.Observer.macro()
  end

  defmacro __using__(:notifier) do
    Observable.Notifier.macro()
  end
end
