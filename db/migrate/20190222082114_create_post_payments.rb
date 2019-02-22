class CreatePostPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :post_payments do |t|

      t.timestamps
    end
  end
end
