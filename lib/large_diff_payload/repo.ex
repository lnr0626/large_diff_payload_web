defmodule LargeDiffPayload.Repo do
  use Ecto.Repo,
    otp_app: :large_diff_payload,
    adapter: Ecto.Adapters.Postgres
end
