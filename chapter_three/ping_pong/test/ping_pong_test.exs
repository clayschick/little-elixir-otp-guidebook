defmodule PingPongTest do
  use ExUnit.Case
  doctest PingPong

  setup_all do
    PingPong.init
    :ok
  end

  test "ping returns pong" do
    PingPong.send_ping(self())
    assert_receive {:ok, "pong"}
  end

  test "pong returns ping" do
    PingPong.send_pong(self())
    assert_receive {:ok, "ping"}
  end
end
