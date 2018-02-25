class Api::V1::TransferenciaController < Api::V1::ApiController
    before_action :set_transferencia, only: [:show]
  
    # GET /api/v1/transferencia
    def index
      #@transferencias = Transferencia.all
      #render json: @transferencias
    end
  
    # GET /api/v1/transferencia/1
    def show
      #render json: @transferencia
    end
  
    # POST /api/v1/transferencia
    def create
      @transferencia = Transferencia.new(transferencia_params)
      @transferencia.tipo = true
      if @transferencia.save
        render json: @transferencia, status: :created
      else
        render json: @transferencia.errors, status: :unprocessable_entity
      end
    end
   
    # PATCH/PUT /api/v1/transferencia/1
    def update
    end
  
    # PUT /api/v1/transferencia/estornar_transferencia
    def estornar_transferencia
      @estorno = Transferencia.new(transferencia_params)
      @estorno.tipo = false
      if @estorno.save
        render json: @estorno
      else
        render json: @estorno.errors, status: :unprocessable_entity
      end
    end
  
  
    # DELETE /api/v1/transferencias/1
    def destroy

    end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_transferencia
      @transferencia = Transferencia.find(params[:id])
    end
   
    # Only allow a trusted parameter "white list" through.
    def transferencia_params
      params.permit(:conta_origem_id, :conta_destino_id, :valor, :tipo, trasacao_estornada_id)
    end
  
  end