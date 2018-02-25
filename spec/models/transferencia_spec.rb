require 'rails_helper'

RSpec.describe Transferencia, type: :model do
  before(:each) do
    @pessoa = Pessoa.create(class_name: 'Fisica', cpf: '01234567890', nome_completo: 'Fulano de Tal', data_nascimento: '01/01/2000')
    @matriz_principal = Conta.create(class_name: 'Matriz', nome: 'Matriz Principal', data_criacao: '01/01/2000', pessoa_id: @pessoa.id)
    @matriz_cancelada = Conta.create(class_name: 'Matriz', nome: 'Matriz', data_criacao: '01/01/2000', pessoa_id: @pessoa.id, status: 'cancelada')
    @filial = Conta.create(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id)
    @filial2 = Conta.create(class_name: 'Filial', nome: 'Filial2', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id)
    @transferencia = Transferencia.new(valor: 10.0, conta_origem_id: @filial2.id, conta_destino_id: @filial.id, tipo: true)
  end

  it 'deve permitir transferencia entre contas filiais' do
    expect(@transferencia).to be_valid
  end
  it 'deve emitir erro caso transferencia entre conta filial e matriz' do
    @transferencia.conta_destino_id = @matriz_principal.id
    @transferencia.conta_origem_id = @filial.id
    expect(@transferencia).to_not be_valid
  end
  it 'deve permitir transferencia entre conta matriz e filial' do
    @transferencia.conta_origem_id = @matriz_principal.id
    expect(@transferencia).to be_valid
  end
  it 'requer conta de origem quando transferencia' do
    @transferencia.conta_destino_id = @filial.id
    @transferencia.conta_origem_id = nil
    expect(@transferencia).to_not be_valid
  end
  it 'requer conta de destino quando transferencia' do
    @transferencia.conta_origem_id = @filial.id
    @transferencia.conta_destino_id = nil
    expect(@transferencia).to_not be_valid
  end
  it 'requer tipo (true - entrada / false - saida)' do
    @transferencia.tipo = nil
    expect(@transferencia).to_not be_valid
  end
  it 'requer tipo (true - entrada / false - saida)' do
    @transferencia.tipo = false
    @transferencia.transacao_estornada_id = 1
    expect(@transferencia).to be_valid
  end
  it 'deve emitir erro quando tranferencia de conta origem cancelada' do
    @filial_cancelada = Conta.create(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id, status: 'cancelada')
    @transferencia.conta_origem_id = @filial_cancelada.id
    expect(@transferencia).to_not be_valid
  end
  it 'deve emitir erro quando tranferencia de conta destino cancelada' do
    @filial_cancelada = Conta.create(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id, status: 'cancelada')
    @transferencia.conta_destino_id = @filial_cancelada.id
    expect(@transferencia).to_not be_valid
  end
  it 'deve emitir erro quando tranferencia de conta origem bloqueada' do
    @filial_bloqueada = Conta.create(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id, status: 'bloqueada')
    @transferencia.conta_origem_id = @filial_bloqueada.id
    expect(@transferencia).to_not be_valid
  end
  it 'deve emitir erro quando tranferencia de conta destino bloqueada' do
    @filial_bloqueada = Conta.create(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id, status: 'bloqueada')
    @transferencia.conta_destino_id = @filial_bloqueada.id
    expect(@transferencia).to_not be_valid
  end
  it 'deve emitiir erro quando valor for negativo' do
    @transferencia.valor = -1.3
    expect(@transferencia).to_not be_valid
  end
  it 'transferencia deve retirar 10 da origem e aumentar 10 do destino' do
    expect(@filial2.saldo).to eq 0.0
    expect(@filial.saldo).to eq 0.0
    @transferencia.save
    expect(@filial2.reload.saldo).to eq -10.0
    expect(@filial.reload.saldo).to eq 10.0
  end
  it 'estorno requer trasacao_estoranada_id' do
    @transferencia.save
    @estorno = Transferencia.new(tipo: false, valor: 10.0, conta_origem_id: @filial2.id, conta_destino_id: @filial.id)
    #@estorno.transacao_estornada_id = @tranferencia.id
    expect(@estorno).to_not be_valid
  end
  it 'estorno de contas filiais deve retirar x do destino e aumentar x da origem'
  it 'estorno deve gravar id da operaçao estornada'
  it 'estorno pode ser feito apenas uma vez por transacao'

end
