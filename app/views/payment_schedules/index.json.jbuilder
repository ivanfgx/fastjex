json.array!(@payment_schedules) do |payment_schedule|
  json.extract! payment_schedule, :id, :account, :regularity, :start_date, :end_date, :amount, :name, :user_id
  json.url payment_schedule_url(payment_schedule, format: :json)
end
