class ArticlesController < ApplicationController
  #http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

	def new
    if current_user then
      @article = Article.new
    else
      redirect_to "/auth/facebook", id: "sign_in"
    end
	end

  def edit
    @article = Article.find(params[:id])
  end

	def create
	  #render json: params[:article]
    @article = Article.new(article_params)
    

    redirect_to @article if @article.save else render "new"
    #render plain: @article.to_json
    #render plain: "article saved!"
    #redirect_to @article
	end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article  
    else 
      render "edit" 
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
