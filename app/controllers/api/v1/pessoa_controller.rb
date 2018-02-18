class Api::V1::PessoaController < Api::V1::ApiController
  before_action :set_pessoa, only: [:show, :update, :destroy]

  # GET /api/v1/pessoas
  def index
    @pessoas = Pessoa.all
    render json: @pessoas
  end

  # GET /api/v1/pessoas/1
  def show
    render json: @pessoa
  end
  
  # POST /api/v1/pessoas
  def create
    @pessoa = Pessoa.new(pessoa_params)
    if @pessoa.save
      render json: @pessoa, status: :created
    else
      render json: @pessoa.errors, status: :unprocessable_entity
    end
  end
    
  # PATCH/PUT /api/v1/pessoas/1
  def update
    if @pessoa.update(pessoa_params)
      render json: @pessoa
    else
      render json: @pessoa.errors, status: :unprocessable_entity
    end
  end
   
  # DELETE /api/v1/pessoas/1
  def destroy
    @pessoa.destroy
  end
   
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pessoa
      @pessoa = Pessoa.find(params[:id])
    end
 
    # Only allow a trusted parameter "white list" through.
    def pessoa_params
      params.permit(:class_name, :cnpj, :razao_social, :nome_fantasia, :cpf, :nome_completo, :data_nascimento)
    end
  
end