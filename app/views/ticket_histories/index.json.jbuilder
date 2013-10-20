json.array!(@ticket_histories) do |ticket_history|
  json.extract! ticket_history, :state, :resolution
  json.url ticket_history_url(ticket_history, format: :json)
end
