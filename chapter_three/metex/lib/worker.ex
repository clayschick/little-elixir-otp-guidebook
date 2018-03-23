defmodule Metex.Worker do
  def loop do
    receive do
      {sender_pid, location} -> send(sender_pid, {:ok, temperature_of(location)})
      _ -> IO.puts("don't know how to process this message")
    end

    loop()
  end

  def temperature_of(location) do
    result =
      url_for(location)
      |> HTTPoison.get()
      |> parse_response

    case result do
      {:ok, temp} -> "#{location}: #{temp}˚F"
      :error -> "Something went wrong"
    end
  end

  defp url_for(location) do
    location = URI.encode(location)

    IO.inspect(
      "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{api_key()}",
      label: "Full URL"
    )
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body
    |> JSON.decode!()
    |> compute_temperature
  end

  defp parse_response(_), do: :error

  defp api_key do
    Application.get_env(:metex, :api_key)
  end

  defp compute_temperature(json) do
    # T(°F) = T(K) × 9/5 - 459.67
    try do
      temp =
        (json["main"]["temp"] * (9 / 5) - 459.67)
        |> Float.round(1)

      {:ok, temp}
    rescue
      _ -> :error
    end
  end
end
