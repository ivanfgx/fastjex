json.array!(@payments) do |payment|
  json.extract! payment, :id, :account, :regularity, :start_date, :end_date, :amount, :name
  json.url payment_url(payment, format: :json)
end
