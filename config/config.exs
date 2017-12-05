# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :notable,
  ecto_repos: [Notable.Repo]

# Configures the endpoint
config :notable, NotableWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lcvTGib3MCB7+rmCJcHENmIhIMhHhOoQsq2J784rC+mCA3+J0lLHxq2nBOuWKk5c",
  render_errors: [view: NotableWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Notable.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
