class CreatePaymentSchedules < ActiveRecord::Migration
  def change
    create_table :payment_schedules do |t|
      t.string :account
      t.string :regularity
      t.datetime :start_date
      t.datetime :end_date
      t.string :amount
      t.string :name
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :payment_schedules, :users
  end
end
