class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :account
      t.string :regularity
      t.datetime :start_date
      t.datetime :end_date
      t.string :amount
      t.string :name

      t.timestamps null: false
    end
  end
end
