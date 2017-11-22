class CreateDomainModels < ActiveRecord::Migration[5.1]
  def change
    create_table :domain_models do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
