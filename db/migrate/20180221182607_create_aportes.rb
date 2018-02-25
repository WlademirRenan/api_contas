class CreateAportes < ActiveRecord::Migration[5.1]
  def change
    create_table :aportes do |t|
      t.integer :conta_destino_id
      t.string  :token
      t.float   :valor
      t.boolean :tipo
      t.string :token_estornado

      t.timestamps
    end
  end
end
