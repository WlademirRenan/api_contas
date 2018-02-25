class Api::V1::AporteController < Api::V1::ApiController
    before_action :set_aporte, only: [:show]
  
    # GET /api/v1/aporte
    def index
      #@aportes = Aporte.all
      #render json: @aportes
    end
  
    # GET /api/v1/aporte/1
    def show
      #render json: @aporte
    end
  
    # POST /api/v1/aporte
    def create
      @aporte = Aporte.new(aporte_params)
      @aporte.tipo = true
      if @aporte.save
        render json: @aporte, status: :created
      else
        render json: @aporte.errors, status: :unprocessable_entity
      end
    end
   
    # PATCH/PUT /api/v1/aporte/1
    def update
    end
  
    # PUT /api/v1/aporte/estornar_aporte
    def estornar_aporte
      @estorno = Aporte.new(aporte_params)
      @estorno.tipo = false
      if @estorno.save
        render json: @estorno
      else
        render json: @estorno.errors, status: :unprocessable_entity
      end
    end
  
  
    # DELETE /api/v1/aportes/1
    def destroy

    end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_aporte
      @aporte = Aporte.find(params[:id])
    end
   
    # Only allow a trusted parameter "white list" through.
    def aporte_params
      params.permit(:conta_destino_id, :valor, :token, :tipo, token_estornado)
    end
  
  end