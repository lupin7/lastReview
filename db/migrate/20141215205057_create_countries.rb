class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.integer :population
      t.decimal :median_age
      t.decimal :life_expectancy
      t.decimal :gdp
      t.boolean :mandatory_military_service

      t.timestamps
    end
  end
end
