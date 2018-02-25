class Transferencia < ApplicationRecord

  belongs_to :conta_destino, class_name: 'Conta', foreign_key: 'conta_destino_id'
  belongs_to :conta_origem, class_name: 'Conta', foreign_key: 'conta_origem_id'

  validates :conta_destino_id, :conta_origem_id, presence: true
  validates :valor, presence: true, if: :entrada?
  validates :tipo, inclusion: { in: [true, false] }
  validates :transacao_estornada_id, presence: true, if: :saida?
  validate :transacao_permitida?

  before_save :movimentar

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

  def entrada?
    tipo.try(:eql?, true)
  end

  def saida?
    tipo.try(:eql?, false)
  end

  def transacao_permitida?
    errors.add(:conta_destino_id, 'Matriz apenas recebe aporte') if conta_destino_matriz?
    errors.add(:base, 'Não são permitidas operações entre contas canceladas ou bloqueadas') unless transacao_entre_contas_validas?
    errors.add(:tipo, 'invalido, permitido apenas true(entrada) ou false(saida)') unless tipo_valido?
    errors.add(:valor, 'não é permitido negativo') if valor.try(:negative?)
  end

  def movimentar
    if tipo.eql? true
      transferir(valor)
    else
      estornar(valor)
    end
  end

  def transferir(valor)
    conta_origem.debitar(valor)
    conta_destino.creditar(valor)
  end

  def estornar(valor)
    conta_destino.debitar(valor)
    conta_origem.creditar(valor)
  end

end
