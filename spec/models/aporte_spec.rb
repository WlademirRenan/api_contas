require 'rails_helper'

RSpec.describe Aporte, type: :model do
  before(:each) do
    @pessoa = Pessoa.create(class_name: 'Fisica', cpf: '01234567890', nome_completo: 'Fulano de Tal', data_nascimento: '01/01/2000')
    @matriz = Conta.create(class_name: 'Matriz', nome: 'Matriz Principal', data_criacao: '01/01/2000', pessoa_id: @pessoa.id)
    @filial = Conta.create(class_name: 'Filial', nome: 'Filial', data_criacao: '01/01/2000', conta_pai_id: @matriz.id, pessoa_id: @pessoa.id)
    @aporte = Aporte.new(valor: 10.0, conta_destino_id: @matriz.id, tipo: true, token: 'asd132')
  end

  it 'requer token quando aporte em conta matriz' do
    @aporte.token = nil
    expect(@aporte).to_not be_valid
  end
  it 'deve realiazar aporte' do
    expect(@aporte).to be_valid
  end
  it 'deve adicionar o valor de 10 na conta matriz quando realizado aporte' do
    expect(@matriz.saldo).to eq 0.0
    @aporte.save
    expect(@matriz.reload.saldo).to eq 10.0
  end
  it 'deve emitir erro quando conta cancelada' do
    @matriz.cancelar
    expect(@aporte).to_not be_valid
  end
  it 'deve emitir erro quando conta bloqueada' do
    @matriz.bloquear
    expect(@aporte).to_not be_valid
  end
  it 'estorno de conta matriz deve retirar x do destino' do
    @aporte.save
    expect(@matriz.reload.saldo).to eq 10.0
    @estorno = Aporte.new(valor: 10.0, conta_destino_id: @matriz.id, tipo: false, token: 'asd1321', token_estornado: 'asd132')
    @estorno.save
    expect(@matriz.reload.saldo).to eq 0.0
  end
  it 'requer token_estornado_id quando estorno em conta matriz' do
    @estorno = Aporte.new(valor: 10.0, conta_destino_id: @matriz.id, tipo: false, token: 'asd1321', token_estornado: 'asd132')
    expect(@estorno).to_not be_valid
  end
end
