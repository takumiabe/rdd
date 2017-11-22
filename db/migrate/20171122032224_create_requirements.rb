class CreateRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :requirements do |t|
      t.text :condition
      t.text :description
      t.text :remark

      t.timestamps
    end
  end
end
