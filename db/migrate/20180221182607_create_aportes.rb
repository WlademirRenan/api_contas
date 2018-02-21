class CreateAportes < ActiveRecord::Migration[5.1]
  def change
    create_table :aportes do |t|
      t.integer :conta_destino_id
      t.string  :token
      t.float   :valor
      t.boolean :tipo
      t.integer :transacao_estornada_id

      t.timestamps
    end
  end
end
