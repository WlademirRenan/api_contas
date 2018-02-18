class CreateConta < ActiveRecord::Migration[5.1]
  def change
    create_table :conta do |t|
      t.integer :conta_pai_id
      t.string :nome
      t.integer :pessoa_id
      t.float :saldo
      t.string :class_name
      t.string :status
      t.date :data_criacao

      t.timestamps
    end
  end
end
