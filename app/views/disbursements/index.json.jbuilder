json.array!(@disbursements) do |disbursement|
  json.extract! disbursement, :id, :date, :accounts_id, :cleared, :amount
  json.url disbursement_url(disbursement, format: :json)
end
