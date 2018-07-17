class AddBuyerToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :buyer_id, :integer
    add_foreign_key :products, :users, {column: :buyer_id}
  end
end
