class AddapkToPaymentSchedule < ActiveRecord::Migration
  def change
  	add_column :payment_schedules, :pak, :string
  end
end
