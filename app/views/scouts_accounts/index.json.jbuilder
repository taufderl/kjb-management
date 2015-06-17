json.array!(@scouts_accounts) do |scouts_account|
  json.extract! scouts_account, :id, :scouts_id
  json.url scouts_account_url(scouts_account, format: :json)
end
