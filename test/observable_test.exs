defmodule ObservableTest do
  use ExUnit.Case

  alias Observable.TestStruct
  alias Observable.TestObserverOne
  alias Observable.TestObserverTwo

  describe "notify/2" do
    test "will send the notification to an observer based on a struct" do
      struct = %TestStruct{}
      Observable.notify(struct, :test_one)

      assert_receive({TestObserverOne, :test_one, ^struct})
      refute_receive({TestObserverTwo, :test_one, ^struct})
    end

    test "will send the notification to an observer based on a list of structs" do
      list_of_structs = [%TestStruct{}, %TestStruct{}]
      Observable.notify(list_of_structs, :test_one)

      assert_receive({TestObserverOne, :test_one, ^list_of_structs})
      refute_receive({TestObserverTwo, :test_one, ^list_of_structs})
    end

    test "will send the notification to multiple observers based on a struct" do
      struct = %TestStruct{}
      Observable.notify(struct, :test_two)

      assert_receive({TestObserverOne, :test_two, ^struct})
      assert_receive({TestObserverTwo, :test_two, ^struct})
    end

    test "will send the notification to multiple observers based on a list of structs" do
      list_of_structs = [%TestStruct{}, %TestStruct{}]
      Observable.notify(list_of_structs, :test_one)

      assert_receive({TestObserverOne, :test_one, ^list_of_structs})
      refute_receive({TestObserverTwo, :test_one, ^list_of_structs})
    end
  end

  describe "notify/3" do
    test "will send the notification to an observer based on a module" do
      struct = %TestStruct{}
      Observable.notify(TestStruct, :test_one, struct)

      assert_receive({TestObserverOne, :test_one, ^struct})
      refute_receive({TestObserverTwo, :test_one, ^struct})
    end

    test "will send the notification to multiple observers based on a module" do
      struct = %TestStruct{}
      Observable.notify(TestStruct, :test_two, struct)

      assert_receive({TestObserverOne, :test_two, ^struct})
      assert_receive({TestObserverTwo, :test_two, ^struct})
    end
  end
end
