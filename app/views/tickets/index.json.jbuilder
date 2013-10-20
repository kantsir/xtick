json.array!(@tickets) do |ticket|
  json.extract! ticket, :subject, :body
  json.url ticket_url(ticket, format: :json)
end
