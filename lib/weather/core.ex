defmodule Weather.Core do
  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions
  that end up generating a table of the last n records in a NAOO XML file
  """

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  Some documentations
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, swithes: [ help: :boolean ], aliases: [ h: :help ])
    case parse do
      { [ help: true ], _, _ } -> :help
      { _, [  ] }
end
