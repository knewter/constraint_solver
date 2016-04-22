defmodule ConstraintSolver do
  def meeting_solver_1(days, meetings) do
    # For each possible assignment of values to the variables v1, v2 (here they're more like {m1, d1})
    # Constraint: for {m1, d1} and {m2, d2}, d1 != d2
    for meeting <- meetings,
        meeting2 <- meetings,
        day <- days,
        day2 <- days,
        meeting < meeting2,
        day != day2 do
      {{meeting, day}, {meeting2, day2}}
    end |> Enum.sort
  end
end

defmodule ConstraintSolverTest do
  use ExUnit.Case

  test "Solving a comically simple constraint" do
    # - We have to have 2 meetings this week
    # - Those 2 meetings cannot occur on the same day
    # - What choices do we have?

    # This is easy to solve via for comprehensions and generators.
    days = [:monday, :tuesday, :wednesday, :thursday, :friday]
    meetings = [:meeting1, :meeting2]
    expected_results = [
      {{:meeting1, :monday}, {:meeting2, :tuesday}},
      {{:meeting1, :monday}, {:meeting2, :wednesday}},
      {{:meeting1, :monday}, {:meeting2, :thursday}},
      {{:meeting1, :monday}, {:meeting2, :friday}},
      {{:meeting1, :tuesday}, {:meeting2, :monday}},
      {{:meeting1, :tuesday}, {:meeting2, :wednesday}},
      {{:meeting1, :tuesday}, {:meeting2, :thursday}},
      {{:meeting1, :tuesday}, {:meeting2, :friday}},
      {{:meeting1, :wednesday}, {:meeting2, :monday}},
      {{:meeting1, :wednesday}, {:meeting2, :tuesday}},
      {{:meeting1, :wednesday}, {:meeting2, :thursday}},
      {{:meeting1, :wednesday}, {:meeting2, :friday}},
      {{:meeting1, :thursday}, {:meeting2, :monday}},
      {{:meeting1, :thursday}, {:meeting2, :tuesday}},
      {{:meeting1, :thursday}, {:meeting2, :wednesday}},
      {{:meeting1, :thursday}, {:meeting2, :friday}},
      {{:meeting1, :friday}, {:meeting2, :monday}},
      {{:meeting1, :friday}, {:meeting2, :tuesday}},
      {{:meeting1, :friday}, {:meeting2, :wednesday}},
      {{:meeting1, :friday}, {:meeting2, :thursday}}
    ]

    assert Enum.sort(expected_results) == Enum.sort(ConstraintSolver.meeting_solver_1(days, meetings))
  end
end
