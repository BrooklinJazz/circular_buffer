# Enbala Interview Code Sample

This is a small project for Elixir candidates to demonstrate their expertise.
The project is standardized across our Elixir applicants, so that we can
compare candidates' skills in an unbiased way.

The goal is to implement a circular buffer: a queue of fixed size, where
when you try to insert into it when it's at capacity, overwrites the oldest
value in the queue.

Your goal is to make the test suite pass (and write reasonably clean code doing it).

🕰 We're aiming for this to take 30 minutes for senior candidates, 1 hour for junior<br>
🐍 Any recent version of Elixir (1.10+) is fine<br>
🔋 No dependencies, please (use the "batteries-included" standard library)<br>
🌅 Feel free to add/remove/alter functions so long as the tested functionality works

A great submission will demonstrate:

- Clarity of thinking (code communicates to your peers and your future self
  first, the computer second)
- An appreciation for Elixir idioms and style
- An ability to manage complexity and think about tradeoffs

## Running tests

Execute the tests with:

```bash
$ mix test
```

### Pending tests

In the test suites, all but the first test have been skipped.

Once you get a test passing, you can unskip the next one by
commenting out the relevant `@tag :pending` with a `#` symbol.

For example:

```elixir
# @tag :pending
test "shouting" do
  assert Bob.hey("WATCH OUT!") == "Whoa, chill out!"
end
```

Or, you can enable all the tests by commenting out the
`ExUnit.configure` line in the test suite.

```elixir
# ExUnit.configure exclude: :pending, trace: true
```
