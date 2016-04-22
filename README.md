# ConstraintSolver

Just a repo in which I try to work my way through constraint solvers with tests.
Starting out super duper basic, and probably failing or losing interest before I
get anywhere interesting.  In other words: nothing to see here, move along (most
likely)

## Naive constraint solutions with generators

Right now there are a couple of naive constraint solutions with generators.
These solve 2 'meeting scheduling' problems:

- 2 meetings in a week, can't occur on the same day
- 3 meetings in a week, meeting3 must be last, no 2 meetings can occur on the
  same day.

It's super straightforward to write these with generators, but they're naive as
currently solved I would assume?  I actually don't know how smart Erlang's for
comprehensions are w/r/t guards.

## Reading

If you want to follow along with my reading list, I'm starting out here:

- [How to Build a Constraint Propagator In a Weekend](http://www.cs.northwestern.edu/~ian/GDCConstraintsHowTo.pdf)
