class Transferencia < ApplicationRecord

  belongs_to :conta_destino, class_name: 'Conta', foreign_key: 'conta_destino_id'
  belongs_to :conta_origem, class_name: 'Conta', foreign_key: 'conta_origem_id'

  validates :conta_destino_id, :valor, presence: true
  validates :tipo, inclusion: { in: [true, false] }
  validates :conta_origem_id, presence: true, if: :conta_destino_filial?
  validate :transacao_permitida?

  def conta_origem_ativa?
    conta_origem.try(:ativa?)
  end

  def conta_destino_ativa?
    conta_destino.try(:ativa?)
  end

  def conta_destino_matriz?
    conta_destino.try(:matriz?)
  end

  def conta_destino_filial?
    conta_destino.try(:filial?)
  end

  def transacao_entre_contas_validas?
    conta_origem_ativa? && conta_destino_ativa?
  end

  def tipo_valido?
    [true, false].include? tipo
  end

  def transacao_permitida?
    errors.add(:conta_destino_id, 'Matriz apenas recebe aporte') if conta_destino_matriz?
    errors.add(:base, 'Não são permitidas operações entre contas canceladas ou bloqueadas') unless transacao_entre_contas_validas?
    errors.add(:tipo, 'invalido, permitido apenas true(entrada) ou false(saida)') unless tipo_valido?
  end

end
