json.array!(@main_accounts) do |main_account|
  json.extract! main_account, :id
  json.url main_account_url(main_account, format: :json)
end
