json.array!(@scouts) do |scout|
  json.extract! scout, :id, :first_name, :last_name, :birthday
  json.url scout_url(scout, format: :json)
end
