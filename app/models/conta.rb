class Conta < ApplicationRecord

  has_many :filiais, class_name: 'Conta', foreign_key: 'conta_pai_id', dependent: :destroy
  before_validation :remover_espacos
  before_save :remover_conta_pai_matriz, if: :matriz?
  before_save :set_ativa
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

  def set_ativa
    self.status = 'ativa' if status.blank?
  end

  def cancelar
    self.status = 'cancelada'
    self.save
    cancelar_filiais
  end

  def cancelar_filiais
    filiais.each do |filial|
      filial.cancelar
    end
  end

  def bloquear
    self.status = 'bloqueada'
    self.save
    bloquear_filiais
  end

  def bloquear_filiais
    filiais.each do |filial|
      filial.bloquear
    end
  end

  def ativar
    self.status = 'ativa'
    self.save
  end

  def ativa?
    status.eql? 'ativa'
  end

end
