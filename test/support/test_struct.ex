defmodule Observable.TestStruct do
  use Observable, :notifier

  defstruct []

  observations do
    action(:test_one, [Observable.TestObserverOne])
    action(:test_two, [Observable.TestObserverOne, Observable.TestObserverTwo])
  end
end
