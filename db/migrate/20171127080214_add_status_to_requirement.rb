class AddStatusToRequirement < ActiveRecord::Migration[5.1]
  def change
    add_column :requirements, :status, :string, index: true, null: false, default: 'in-review'
  end
end
