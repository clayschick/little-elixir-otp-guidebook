defmodule Ping do
  def loop do
    receive do
      {sender_pid, "ping"} -> send(sender_pid, {:ok, "pong"})
      _ -> IO.puts("bro, do you even ping")
    end
    loop()
  end
end