defmodule ChapterTwo do
  @moduledoc """
  Exercizes for ChapterTwo.
  """

  @doc """
  Exercise 1 - The sum function
  """
  def sum([], acc), do: acc
  def sum([head | tail], acc), do: sum(tail, head + acc)

  @doc """
  Exercise 1 - The sum function using Enum module
  """
  def sum_using_enum(num_list), do: Enum.reduce(num_list, 0, &(&1 + &2))

  @doc """
  Exercise 3 - Flatten, reverse, and double a list of nested lists
  without using the pipe operator
  """
  def transform(a_list) do
    Enum.map(Enum.reverse(List.flatten(a_list)), &(&1 * &1))
  end

  @doc """
  Exercise 3 - Flatten, reverse, and double a list of nested lists
  using the pipe operator
  """
  def transform_with_pipe(a_list) do
    a_list
    |> List.flatten()
    |> Enum.reverse()
    |> Enum.map(&(&1 * &1))
  end

  @doc """
  Exercise 4 - “Translate crypto:md5("Tales from the Crypt"). from Erlang to Elixir.”

  Not real sure what to do with this one.
  """
  def translate_md5 do
    hash = :erlang.md5("Tales from the Crypt")
  end

  @doc """
  Exercise 6 - IPv4 parser

  Snagged a packet using Wireshark and using the Export Packet Bytes... feature
  Used these to figure out the structure of a packet header:
  - https://www.tutorialspoint.com/ipv4/ipv4_packet_structure.htm
  - http://www.erg.abdn.ac.uk/users/gorry/course/inet-pages/ip-packet.html
  """
  def inspect_packet do
    packet_binary = File.read!('./packet.bin')
    IO.inspect(packet_binary, label: "Packet binary")

    <<
      version :: 4,
      ihl :: 4,
      dscp :: 6,
      ecn :: 2,
      total_length :: 16,
      identification :: 16,
      flags :: 3,
      fragment_offset :: 13,
      ttl :: 8,
      protocol :: 8,
      header_checksum :: 16,
      source_address :: 32, # <- could just take 8 at a time to get each octet 
      destination_address :: 32,
      rest :: binary
    >> = packet_binary

    IO.inspect(version, label: "IP version")
    IO.inspect(ihl, label: "Header length")
    IO.inspect(dscp, label: "Differentiated Services Code Point")
    IO.inspect(ecn, label: "Explicit Congestion Notification")
    IO.inspect(total_length, label: "Total Length")
    IO.inspect(identification, label: "Identification")
    IO.inspect(flags, label: "Flags")
    IO.inspect(fragment_offset, label: "Fragment offset")
    IO.inspect(ttl, label: "TTL")
    IO.inspect(protocol, label: "Protocol - 6 is TCP, 17 is UDP")
    IO.inspect(header_checksum, label: "Header checksum")
    IO.inspect(ip_string(source_address), label: "Source address")
    IO.inspect(ip_string(destination_address), label: "Destination address")

    IO.inspect rest
  end

  defp ip_string(int) do
    <<
      octet_one :: 8,
      octet_two :: 8,
      octet_three :: 8,
      octet_four :: 8
    >> = <<int::32>> # <- converts an integer to 32 bit binary

    Enum.map([octet_one, octet_two, octet_three, octet_four], &(Integer.to_string(&1)))
    |> Enum.join(".")
  end
end
