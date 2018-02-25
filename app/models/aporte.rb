class Aporte < ApplicationRecord
  belongs_to :conta_destino, class_name: 'Conta', foreign_key: 'conta_destino_id'

  validates :conta_destino_id, :valor, :token, presence: true
  validates :tipo, inclusion: { in: [true, false] }
  validates :token, uniqueness: true
  validate :transacao_permitida?

  before_save :movimentar

  def transacao_permitida?
    errors.add(:conta_destino_id, 'Filial apenas recebe transferencia') if conta_destino_filial?
    errors.add(:base, 'Não são permitidas operações entre contas canceladas ou bloqueadas') unless transacao_entre_contas_validas?
    errors.add(:token, 'não é o mesmo da operação original') if token_diferente?
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

  def movimentar
    if tipo.eql? true
      transferir(valor)
    else
      estornar(valor)
    end
  end

  def transferir(valor)
    conta_destino.creditar(valor)
  end

  def estornar(valor)
    conta_destino.debitar(valor)
  end

  def token_diferente?
    return false if entrada?
    result = false
    if token
      original = Transferencia.where(token: token).first
      result = token != original.token
    end
    result
  end
end
