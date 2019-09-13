class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :rated]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]
  before_action :set_star, only: [:show, :rated]

  helper_method :ordenar_coluna, :ordernar_direcao


  # GET /posts
  def index
    @posts = Post.order(ordenar_coluna + " " + ordernar_direcao)
  end

  # GET /posts/1
  def show
    @commentaries = Commentary.where(post_id: @post.id)
    @new_commentary = @post.commentaries.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post criado com sucesso!'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post atualizado com sucesso!'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post Deletado com sucesso!'
  end

  # PATCH /posts/1/rated
  def rated
    @star.change_rated
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end

    def check_ownership
        redirect_to posts_url, notice: 'Você não pode alterar um post que não é seu!' if @post.user.id != current_user.id
    end

    def set_star
      @star =
      if star_querry = Star.where("user_id = ? AND post_id = ?", current_user.id, params[:id]).first
        star_querry
      else
        star = @post.stars.build(user_id: current_user.id, post_id: @post.id).save()
        set_star
      end
    end

    def ordenar_coluna
      Post.column_names.include?(params[:ordenar]) ? params[:ordenar] : 'title'
    end
    
    def ordernar_direcao
      %w[asc desc].include?(params[:direcao]) ? params[:direcao] : 'asc'
    end
    
end
