json.array!(@staffs) do |staff|
  json.extract! staff, :name
  json.url staff_url(staff, format: :json)
end
