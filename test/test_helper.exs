ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Handsup.Repo, :manual)
ExUnit.configure exclude: :pending, trace: true

