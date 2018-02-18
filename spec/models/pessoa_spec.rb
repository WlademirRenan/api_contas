require 'rails_helper'

RSpec.describe Pessoa, type: :model do
  it 'fisica deve obrigar cpf'
  it 'fisica deve obrigar nome completo'
  it 'nome completo deve ser maior que 3 caracteres'
  it 'fisica deve obrigar data nascimento'
  it 'cpf deve conter 11 digitos'

  it 'juridica deve obrigar cnpj'
  it 'juridica deve obrigar razao social'
  it 'razao social deve ser maior que 3 caracteres'
  it 'juridica deve obrigar nome fantasia'
  it 'nome fantasia dee ser maior que 3 caracteres'
end
