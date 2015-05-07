json.array!(@tents) do |tent|
  json.extract! tent, :id, :number
  json.url tent_url(tent, format: :json)
end
