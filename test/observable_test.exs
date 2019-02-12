defmodule ObservableTest do
  use ExUnit.Case

  alias Observable.TestStruct
  alias Observable.TestObserverOne
  alias Observable.TestObserverTwo

  describe "notify_for/2" do
    test "will send the notification to an observer based on a struct" do
      struct = %TestStruct{}
      Observable.notify_for(struct, :test_one)

      assert_receive({TestObserverOne, :test_one, ^struct})
      refute_receive({TestObserverTwo, :test_one, ^struct})
    end

    test "will send the notification to multiple observers based on a struct" do
      struct = %TestStruct{}
      Observable.notify_for(struct, :test_two)

      assert_receive({TestObserverOne, :test_two, ^struct})
      assert_receive({TestObserverTwo, :test_two, ^struct})
    end
  end

  describe "notify_all/3" do
    test "will send the notification to an observer based on a module" do
      struct = %TestStruct{}
      Observable.notify_all(TestStruct, :test_one, struct)

      assert_receive({TestObserverOne, :test_one, ^struct})
      refute_receive({TestObserverTwo, :test_one, ^struct})
    end

    test "will send the notification to multiple observers based on a module" do
      struct = %TestStruct{}
      Observable.notify_all(TestStruct, :test_two, struct)

      assert_receive({TestObserverOne, :test_two, ^struct})
      assert_receive({TestObserverTwo, :test_two, ^struct})
    end
  end
end
