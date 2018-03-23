defmodule Pong do
  def loop do
    receive do
      {sender_pid, "pong"} -> send(sender_pid, {:ok, "ping"})
      _ -> IO.puts("bro, do you even pong")
    end
    loop()
  end
end