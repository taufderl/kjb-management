json.array!(@bookings) do |booking|
  json.extract! booking, :id, :date, :accounts_id, :amount, :note1, :note2, :remarks, :created_by, :updated_by, :accounting_number
  json.url booking_url(booking, format: :json)
end
