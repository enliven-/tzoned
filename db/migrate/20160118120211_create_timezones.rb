class CreateTimezones < ActiveRecord::Migration
  def change
    create_table :timezones do |t|
      t.string :name
      t.integer :city_id
      t.integer :gmt_difference
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
