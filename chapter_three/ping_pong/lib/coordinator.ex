defmodule Coordinator do
  def loop() do
    receive do
      {:ok, result} -> IO.puts result

      loop()
    end
  end
end