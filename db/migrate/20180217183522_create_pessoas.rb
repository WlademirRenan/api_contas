class CreatePessoas < ActiveRecord::Migration[5.1]
  def change
    create_table :pessoas do |t|
      t.string :class_name
      t.string :cnpj
      t.string :razao_social
      t.string :nome_fantasia
      t.string :cpf
      t.string :nome_completo
      t.date :data_nascimento

      t.timestamps
    end
  end
end
