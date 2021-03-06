class DocsController < ApplicationController
  before_action :find_doc, only: [:show, :edit, :update, :destroy]
  before_action :authenticated
  def index
    @docs = Doc.where(user_id: current_user).order('created_at DESC')
  end

  def create
  	@doc = current_user.docs.build(doc_params)
  	if @doc.save
  		redirect_to @doc
  	else
  		render 'new'
  	end
  end

  def new
  	@doc = current_user.docs.build
  end

  def edit
  end

  def show
  end

  def update
  	if @doc.update(doc_params)
  		redirect_to @doc
  	else
  		render 'edit'
  	end
  end

  def destroy
  	if @doc.destroy
  		redirect_to docs_path
  	else
  		doc_path
  	end
  end

  private

    def find_doc
    	@doc = Doc.find(params[:id])
    end

    def doc_params
    	params.require(:doc).permit(:title, :content)
    end

    def authenticated
      if !current_user
      	redirect_to new_user_session_path
      end
    end
end
