require 'rails_helper'

RSpec.describe Transferencia, type: :model do
  before(:each) do
    @pessoa = Pessoa.create(class_name: 'Fisica', cpf: '01234567890', nome_completo: 'Fulano de Tal', data_nascimento: '01/01/2000')
    @matriz_principal = Conta.create(class_name: 'Matriz', nome: 'Matriz Principal', data_criacao: '01/01/2000', pessoa_id: @pessoa.id)
    @matriz_cancelada = Conta.create(class_name: 'Matriz', nome: 'Matriz', data_criacao: '01/01/2000', pessoa_id: @pessoa.id, status: 'cancelada')
    @filial = Conta.create(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id)
    @filial2 = Conta.create(class_name: 'Filial', nome: 'Filial2', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id)
    @filial_cancelada = Conta.create(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id, status: 'cancelada')
  end

  it 'deve permitir transferencia entre contas filiais' do
    @matriz.nome = nil
    expect(@matriz).to_not be_valid
  end
  it 'deve emitir erro caso transferencia entre conta filial e matriz'
  it 'deve emitir erro caso transferencia entre conta matriz e filial'
  it 'requer token quando aporte em conta matriz'
  it 'requer conta de origem quando transferencia'
  it 'requer conta de destino quando transferencia'
  it 'requer token quando estorno em conta matriz'
  it 'dever emitir erro quando tranferencia de conta origem cancelada'
  it 'dever emitir erro quando tranferencia de conta destino cancelada'
  it 'dever emitir erro quando tranferencia de conta origem bloqueada'
  it 'dever emitir erro quando tranferencia de conta destino bloqueada'
  it 'estorno deve remover valor com base no token'
  it 'estorno de contas filiais deve retirar x do destino e aumentar x da origem'
  it 'estorno deve gravar id da operaçao estornada'
  it 'estorno pode ser feito apenas uma vez por transacao'
  it 'requer conta de origem quando estorno'
  it 'requer conta de destino quando estorno'
end
