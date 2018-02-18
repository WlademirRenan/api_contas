class Conta < ApplicationRecord
  before_validation :remover_espacos
  before_save :remover_conta_pai_matriz, if: :matriz?
  validates :nome, :data_criacao, :class_name, :pessoa_id, presence: true
  validates :conta_pai_id, presence: true, if: :filial?
  validates_length_of :nome, minimum: 3

  def matriz?
    class_name.eql? 'Matriz'
  end

  def filial?
    class_name.eql? 'Filial'
  end

  def remover_espacos
    nome.to_s.squish!
    data_criacao.to_s.squish!
  end

  def remover_conta_pai_matriz
    self.conta_pai_id = nil
  end
end
