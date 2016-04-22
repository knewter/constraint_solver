defmodule ConstraintSolver do
  def meeting_solver_1(days, meetings) do
    # For each possible assignment of values to the variables v1, v2 (here they're more like {m1, d1})
    # Constraint: for {m1, d1} and {m2, d2}, d1 != d2
    for meeting <- meetings,
        meeting2 <- meetings,
        day <- days,
        day2 <- days,
        meeting < meeting2, # Just to avoid semantic-duplicates
        day != day2 do
      {{meeting, day}, {meeting2, day2}}
    end |> Enum.sort
  end

  def meeting_solver_2(days, meetings) do
    # For each possible assignment of values to the variables v1, v2 (here they're more like {m1, d1})
    # Constraint: for {m1, d1}, {m2, d2}, {m3, d3}, d1 != d2, d1 != d3, d2 != d3, d3 > d1, d3 > d2
    for meeting <- meetings,
        meeting2 <- meetings,
        meeting3 <- meetings,
        day <- days,
        day2 <- days,
        day3 <- days,
        meeting < meeting2, # Just to avoid semantic-duplicates
        meeting2 < meeting3, # Just to avoid semantic-duplicates
        day != day2,
        day != day3,
        day2 != day3,
        day3 > day,
        day3 > day2 do
      {{meeting, day}, {meeting2, day2}, {meeting3, day3}}
    end |> Enum.sort
  end
end

defmodule ConstraintSolverTest do
  use ExUnit.Case

  test "2 meetings on different days of the week" do
    # - We have to have 2 meetings this week
    # - Those 2 meetings cannot occur on the same day
    # - What choices do we have?

    # This is easy to solve via for comprehensions and generators.
    days = [1, 2, 3, 4, 5]
    meetings = [:meeting1, :meeting2]
    expected_results = [
      {{:meeting1, 1}, {:meeting2, 2}},
      {{:meeting1, 1}, {:meeting2, 3}},
      {{:meeting1, 1}, {:meeting2, 4}},
      {{:meeting1, 1}, {:meeting2, 5}},
      {{:meeting1, 2}, {:meeting2, 1}},
      {{:meeting1, 2}, {:meeting2, 3}},
      {{:meeting1, 2}, {:meeting2, 4}},
      {{:meeting1, 2}, {:meeting2, 5}},
      {{:meeting1, 3}, {:meeting2, 1}},
      {{:meeting1, 3}, {:meeting2, 2}},
      {{:meeting1, 3}, {:meeting2, 4}},
      {{:meeting1, 3}, {:meeting2, 5}},
      {{:meeting1, 4}, {:meeting2, 1}},
      {{:meeting1, 4}, {:meeting2, 2}},
      {{:meeting1, 4}, {:meeting2, 3}},
      {{:meeting1, 4}, {:meeting2, 5}},
      {{:meeting1, 5}, {:meeting2, 1}},
      {{:meeting1, 5}, {:meeting2, 2}},
      {{:meeting1, 5}, {:meeting2, 3}},
      {{:meeting1, 5}, {:meeting2, 4}}
    ]

    assert Enum.sort(expected_results) == Enum.sort(ConstraintSolver.meeting_solver_1(days, meetings))
  end

  test "m1, m2, m3 on different days of the week, m3 must come last" do
    # - We have to have 3 meetings this week: m1, m2, m3
    # - No 2 meetings can occur on the same day
    # - m3 must come last

    days = [1, 2, 3, 4, 5]
    meetings = [:meeting1, :meeting2, :meeting3]

    results = ConstraintSolver.meeting_solver_2(days, meetings)
    for {{m1, d1}, {m2, d2}, {m3, d3}} <- results do
      assert m3 > m1
      assert m3 > m2
      assert d1 != d2
      assert d1 != d3
      assert d2 != d3
    end
  end
end
