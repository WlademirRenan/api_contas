require 'rails_helper'

RSpec.describe Aporte, type: :model do
  before(:each) do
    @pessoa = Pessoa.create(class_name: 'Fisica', cpf: '01234567890', nome_completo: 'Fulano de Tal', data_nascimento: '01/01/2000')
    @matriz = Conta.create(class_name: 'Matriz', nome: 'Matriz Principal', data_criacao: '01/01/2000', pessoa_id: @pessoa.id)
    @matriz_cancelada = Conta.create(class_name: 'Matriz', nome: 'Matriz', data_criacao: '01/01/2000', pessoa_id: @pessoa.id, status: 'cancelada')
    @filial = Conta.create(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz.id, pessoa_id: @pessoa.id)
    @aporte = Aporte.new(valor: 10.0, conta_destino_id: @matriz.id, tipo: true, token: 'asd132')
  end

  it 'requer token quando aporte em conta matriz' do
    @aporte.token = nil
    expect(@aporte).to_not be_valid
  end
  it 'deve realiazar aporte'
  it 'estorno de contas matriz deve retirar x do destino'
  it 'deve emitir erro quando conta cancelada'
  it 'deve emitir erro quando conta bloqueada'
  it 'requer token quando estorno em conta matriz'
  it 'estorno deve remover valor com base no token'
end
