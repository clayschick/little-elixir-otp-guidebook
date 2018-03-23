defmodule PingPong do
  def init do
    ping_pid = spawn(Ping, :loop, [])
    pong_pid = spawn(Pong, :loop, [])
    coordinator_pid = spawn(Coordinator, :loop, [])

    Process.register(ping_pid, :ping_process)
    Process.register(pong_pid, :pong_process)
    Process.register(coordinator_pid, :coordinator_process)
  end

  def send_ping(sender_process \\ :coordinator_process) do
    send(:ping_process, {sender_process, "ping"})
  end

  def send_pong(sender_process \\ :coordinator_process) do
    send(:pong_process, {sender_process, "pong"})
  end
end
