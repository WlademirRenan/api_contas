require 'rails_helper'

RSpec.describe Conta, type: :model do
  it 'matriz deve obrigar nome'
  it 'matriz deve obrigar pessoa_id'
  it 'matriz deve conter data criacao'
  it 'matriz pode ter contas filhas'
  it 'matriz deve conter conter conta_pai_id nula'
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
