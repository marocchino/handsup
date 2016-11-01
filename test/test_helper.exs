ExUnit.start
Ecto.Adapters.SQL.Sandbox.mode(Handsup.Repo, :manual)
ExUnit.configure seed: elem(:os.timestamp, 2), exclude: :pending, trace: true
Ffaker.Seed.reset
