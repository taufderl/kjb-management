json.array!(@children_accounts) do |children_account|
  json.extract! children_account, :id, :children_id
  json.url children_account_url(children_account, format: :json)
end
