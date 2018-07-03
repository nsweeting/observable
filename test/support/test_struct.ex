defmodule Observable.TestStruct do
  use Observable, :notifier

  defstruct []

  observations do
    on_action(:test_one, Observable.TestObserverOne)
    on_action(:test_two, Observable.TestObserverOne)
    on_action(:test_two, Observable.TestObserverTwo)
  end
end
