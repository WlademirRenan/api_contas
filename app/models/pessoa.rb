class Pessoa < ApplicationRecord
  validates :class_name, presence: true
  validates :cnpj, :razao_social, :nome_fantasia, presence: true, if: fisica?
  validates :cpf, :nome_completo, :data_nascimento, presence: true, if: juridica?

  def fisica?
    class_name.eql? 'Fisica'
  end

  def juridica?
    class_name.eql? 'Juridica'
  end
end
