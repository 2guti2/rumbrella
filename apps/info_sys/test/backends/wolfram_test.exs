defmodule InfoSys.Backends.WolframTest do
  use ExUnit.Case, async: true
  alias InfoSys.Wolfram

  test "makes request, reports results, then terminates" do
    ref = make_ref()
    {:ok, pid} = Wolfram.start_link("1 + 1", ref, self(), 1)
    Process.monitor(pid)

    # TODO: grab an xml response from wolfram and place it in wolfram.xml file for the operation 1+1
    assert_receive {:results, _ref, []}
    assert_receive {:DOWN, _ref, :process, ^pid, :normal}
  end

  test "no query results reports an empty list" do
    ref = make_ref()
    {:ok, _} = Wolfram.start_link("none", ref, self(), 1)

    assert_receive {:results, ^ref, []}
  end
end
