class CreateTransferencia < ActiveRecord::Migration[5.1]
  def change
    create_table :transferencia do |t|
      t.float :valor
      t.boolean :tipo
      t.integer :conta_origem_id
      t.integer :conta_destino_id
      t.string :token

      t.timestamps
    end
  end
end
