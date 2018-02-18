class Pessoa < ApplicationRecord
  before_validation :remover_espacos
  validates :class_name, presence: true
  validates :cpf, :nome_completo, :data_nascimento, presence: true, if: :fisica?
  validates_length_of :cpf, minimum: 11, maximum: 11, if: :fisica?
  validates_length_of :nome_completo, minimum: 3, if: :fisica?
  validates :cnpj, :razao_social, :nome_fantasia, presence: true, if: :juridica?
  validates_length_of :cnpj, minimum: 14, maximum: 14, if: :juridica?
  validates_length_of :razao_social, :nome_fantasia, minimum: 3, if: :juridica?

  def fisica?
    class_name.eql? 'Fisica'
  end

  def juridica?
    class_name.eql? 'Juridica'
  end

  def remover_espacos
    cpf.to_s.gsub!(/[^0-9]/, '')#.squish!
    cnpj.to_s.gsub!(/[^0-9]/, '')
    nome_completo.to_s.squish!
    razao_social.to_s.squish!
    nome_fantasia.to_s.squish!
  end
end
