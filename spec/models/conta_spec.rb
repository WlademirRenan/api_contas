require 'rails_helper'

RSpec.describe Conta, type: :model do
  before(:each) do
    @pessoa = Pessoa.create(class_name: 'Fisica', cpf: '01234567890', nome_completo: 'Fulano de Tal', data_nascimento: '01/01/2000')
    @matriz_principal = Conta.create(class_name: 'Matriz', nome: 'Matriz Principal', data_criacao: '01/01/2000', pessoa_id: @pessoa.id)
    @matriz = Conta.new(class_name: 'Matriz', nome: 'Matriz', data_criacao: '01/01/2000', pessoa_id: @pessoa.id)
    @filial = Conta.new(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz_principal.id, pessoa_id: @pessoa.id)
  end

  it 'matriz deve obrigar nome' do
    @matriz.nome = nil
    expect(@matriz).to_not be_valid
  end
  it 'matriz deve obrigar no minimo 3 caracteres para o nome' do
    @matriz.nome = '12         '
    expect(@matriz).to_not be_valid
  end
  it 'matriz deve obrigar pessoa_id' do
    @matriz.pessoa_id = nil
    expect(@matriz).to_not be_valid
  end
  it 'matriz deve conter data criacao' do
    @matriz.data_criacao = nil
    expect(@matriz).to_not be_valid
  end
  it 'matriz pode ter contas filhas'
  it 'matriz deve conter conter conta_pai_id nula' do
    @matriz.conta_pai_id = 1
    @matriz.save
    expect(@matriz.conta_pai_id).to eq nil
  end
  it 'deve cancelar contas filiais vinculadas quando cancelar matriz'
  it 'deve bloquear contas filiais vinculadas quando bloquear matriz'

  it 'filial deve obrigar conta_pai_id'
  it 'filial deve obrigar nome'
  it 'filial deve obrigar pessoa_id'
  it 'filial deve conter data criacao'
  it 'filial pode ter contas filhas'

  it 'deve permitir transferencia entre contas filiais'
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
  it 'requer conta de origem quando estorno'
  it 'requer conta de destino quando estorno'

  it 'quando cancelar conta status deve ser cancelada'
  it 'quando bloquear conta status deve ser bloqueada'
  it 'quando ativar conta status deve ser ativa'
  # ativa,bloqueada, cancelada
end