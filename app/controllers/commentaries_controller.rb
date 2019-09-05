class CommentariesController < ApplicationController
  before_action :set_commentary, only: [:show, :edit, :update, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]

  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]

  # GET /commentaries/1/edit
  def edit
  end

  # POST /commentaries
  def create
    @commentary = current_user.commentaries.new(commentary_params)

    if @commentary.save
      redirect_to post_path(@commentary.post_id), notice: 'Comentario criado com sucesso!'
    else
      redirect_to post_path(@commentary.post_id), notice: 'Acontecel um error'
    end
  end

  # PATCH/PUT /commentaries/1
  def update
    if @commentary.update(commentary_params)
      redirect_to post_path(@commentary.post_id), notice: 'Comentario atualizado com sucesso!'
    else
      redirect_to post_path(@commentary.post_id), notice: 'Acontecel um error'
    end
  end

  # DELETE /commentaries/1
  def destroy
    if @commentary.destroy
      redirect_to post_path(@commentary.post_id), notice: 'Comentario deletado com sucesso!'
    else
      redirect_to post_path(@commentary.post_id), notice: 'Acontecel um error'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commentary
      @commentary = Commentary.find(params[:id])
    end

    def set_post
      @post = @commentary.post
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commentary_params
      params.require(:commentary).permit(:commentary_text, :post_id, :user_id)
    end

    def check_ownership
      redirect_to post_path(@commentary.post_id), notice: 'Você não pode alterar um Comentario que não é seu!' if @commentary.user.id != current_user.id
    end
end
