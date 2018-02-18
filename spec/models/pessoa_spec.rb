require 'rails_helper'

RSpec.describe Pessoa, type: :model do
  before(:each) do
    @fisica = Pessoa.new(class_name: 'Fisica', cpf: '01234567890', nome_completo: 'Fulano de Tal', data_nascimento: '01/01/2000')
    @juridica = Pessoa.new(class_name: 'Juridica', cnpj: '01234567890123', nome_fantasia: 'Fulano Corp', razao_social: 'Fulano LTDA')
  end
  it 'fisica deve obrigar cpf' do
    @fisica.cpf = nil
    expect(@fisica).to_not be_valid
  end
  it 'fisica deve obrigar nome completo' do
    @fisica.nome_completo = nil
    expect(@fisica).to_not be_valid
  end
  it 'nome completo deve ser maior que 3 caracteres sem contar espaços' do
    @fisica.nome_completo = 'a            '
    expect(@fisica).to_not be_valid
  end
  it 'nome completo deve ser maior que 3 caracteres' do
    @fisica.nome_completo = 'ab'
    expect(@fisica).to_not be_valid
  end
  it 'fisica deve obrigar data nascimento' do
    @fisica.data_nascimento = nil
    expect(@fisica).to_not be_valid
  end
  it 'cpf deve conter 11 digitos' do
    @fisica.cpf = '12345678'
    expect(@fisica).to_not be_valid
  end
  it 'cpf deve conter 11 digitos sem contar espaços' do
    @fisica.cpf = '0123456789 '
    expect(@fisica).to_not be_valid
  end

  it 'juridica deve obrigar cnpj' do
    @juridica.cnpj = nil
    expect(@juridica).to_not be_valid
  end
  it 'juridica deve obrigar razao social' do
    @juridica.razao_social = nil
    expect(@juridica).to_not be_valid
  end
  it 'razao social deve ser maior que 3 caracteres' do
    @juridica.razao_social = 'a       '
    expect(@juridica).to_not be_valid
  end
  it 'juridica deve obrigar nome fantasia' do
    @juridica.nome_fantasia = nil
    expect(@juridica).to_not be_valid
  end
  it 'nome fantasia dee ser maior que 3 caracteres' do
    @juridica.nome_fantasia = 'a         '
    expect(@juridica).to_not be_valid
  end
  it 'fisica deve ser valida' do
    expect(@fisica).to be_valid
  end
  it 'juridica deve ser valida' do
    expect(@juridica).to be_valid
  end
  it 'obriga class_name' do
    @fisica.class_name = nil
    expect(@fisica).to_not be_valid
  end
end
