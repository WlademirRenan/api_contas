class Api::V1::ContaController < Api::V1::ApiController
  before_action :set_conta, only: [:show, :update, :destroy, :cancelar, :bloquear, :ativar]

  # GET /api/v1/contas
  def index
    @contas = Conta.all
    render json: @contas
  end

  # GET /api/v1/contas/1
  def show
    render json: @conta
  end

  # POST /api/v1/contas
  def create
    @conta = Conta.new(conta_params)
    if @conta.save
      render json: @conta, status: :created
    else
      render json: @conta.errors, status: :unprocessable_entity
    end
  end
 
  # PATCH/PUT /api/v1/contas/1
  def update
    if @conta.update(conta_params)
      render json: @conta
    else
      render json: @conta.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/conta/1/cancelar
  def cancelar
    if @conta.cancelar(conta_params)
      render json: @conta
    else
      render json: @conta.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/conta/1/bloquear
  def bloquear
    if @conta.cancelar(conta_params)
      render json: @conta
    else
      render json: @conta.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/conta/1/ativar
  def ativar
    if @conta.cancelar(conta_params)
      render json: @conta
    else
      render json: @conta.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/contas/1
  def destroy
    # @conta.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conta
    @conta = Conta.find(params[:id])
  end
 
  # Only allow a trusted parameter "white list" through.
  def conta_params
    params.permit(:conta_pai_id, :nome, :pessoa_id, :data_criacao)
  end

end