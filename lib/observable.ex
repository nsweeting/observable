defmodule Observable do
  @type notifier :: module()
  @type observer :: module()
  @type action :: atom()
  @type result :: :ok | {:ok, term()} | {:error, term()}
  @type data :: term()

  @doc """
  Returns a list of all observers for a given notifier and action.

  ## Example

      Observable.observers(Notifier, :action_name)
  """
  @spec observers(Observable.notifier(), Observable.action()) :: [Observable.observer()]
  def observers(notifier, action) do
    notifier.__observers__(action)
  end

  @doc """
  Notifies all observers of the given `data` struct that `action` has occured.

  The `data` passed to the observers will be the struct itself.

  ## Example

      Observable.notify_for(%Notifier{}, :action_name)
  """
  @spec notify_for([%{__struct__: module()}] | %{__struct__: module()}, Observable.action()) :: [
          Observable.result()
        ]
  def notify_for(%_{} = data, action) do
    notifier = data.__struct__
    notify_all(notifier, action, data)
  end

  @doc """
  Notifies all observers of the given `notifier` that `action` has occured.

  All the observers will be passed `data`.

  ## Example

      Observable.notify_all(Notifier, :action_name, data)
  """
  @spec notify_all(Observable.notifier(), Observable.action(), Observable.data()) :: [
          Observable.Observer.result()
        ]
  def notify_all(notifier, action, data) do
    for observer <- observers(notifier, action) do
      notify_one(observer, action, data)
    end
  end

  @doc """
  Notifies an `observer` that `action` has occured.

  The `observer` will be passed `data`.

  ## Example

      Observable.notify_one(Observer, :action_name, data)
  """
  @spec notify_one(Observable.observer(), Observable.action(), Observable.data()) ::
          Observable.Observer.result()
  def notify_one(observer, action, data) do
    apply(observer, :handle_notify, [action, data])
  end

  defmacro __using__(:observer) do
    Observable.Observer.macro()
  end

  defmacro __using__(:notifier) do
    Observable.Notifier.macro()
  end
end
