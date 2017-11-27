class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.belongs_to :requirement, foreign_key: true
      t.string :title
      t.text :description
      t.text :remark

      t.timestamps
    end
  end
end
