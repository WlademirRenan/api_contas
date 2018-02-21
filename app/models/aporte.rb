class Aporte < ApplicationRecord
  belongs_to :conta_destino, class_name: 'Conta', foreign_key: 'conta_destino_id'

  validates :conta_destino_id, :valor, :token, presence: true
  validates :tipo, inclusion: { in: [true, false] }

  validate :transacao_permitida?

  def transacao_permitida?
    errors.add(:conta_destino_id, 'Filial apenas recebe transferencia') if conta_destino_filial?
    errors.add(:base, 'Não são permitidas operações entre contas canceladas ou bloqueadas') unless transacao_entre_contas_validas?
  end

  def conta_destino_filial?
    conta_destino.try(:filial?)
  end

  def transacao_entre_contas_validas?
    conta_destino_ativa?
  end

  def conta_destino_ativa?
    conta_destino.try(:ativa?)
  end
end
