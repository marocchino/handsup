use Mix.Config
# Configure your database
config :handsup, Handsup.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "handsup_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
