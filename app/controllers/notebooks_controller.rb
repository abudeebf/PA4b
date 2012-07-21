class NotebooksController < ApplicationController
   before_filter :signed_in_user, only: [:new,:create, :edit, :update,:delete]
  # GET /notebooks
  # GET /notebooks.json
  def index
    @notebooks = Notebook.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notebooks }
    end
  end

  # GET /notebooks/1
  # GET /notebooks/1.json
  def show
    @notebook = Notebook.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notebook }
    end
  end

  # GET /notebooks/new
  # GET /notebooks/new.json
  def new
    @notebook = Notebook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notebook }
    end
  end

  # GET /notebooks/1/edit
  def edit
    @notebook = Notebook.find(params[:id])
  end

  # POST /notebooks
  # POST /notebooks.json
  def create
    @notebook =  current_user.notebooks.build(params[:notebook])
           
    respond_to do |format|
      if @notebook.save
        format.html { redirect_to @notebook, notice: 'Notebook was successfully created.' }
        format.json { render json: @notebook, status: :created, location: @notebook }
      else
        format.html { render action: "new" }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notebooks/1
  # PUT /notebooks/1.json
  def update
    @notebook = Notebook.find(params[:id])

    respond_to do |format|
      if @notebook.update_attributes(params[:notebook])
        format.html { redirect_to @notebook, notice: 'Notebook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notebooks/1
  # DELETE /notebooks/1.json
  def destroy
    @notebook = Notebook.find(params[:id])
    @notebook.destroy

    respond_to do |format|
      format.html { redirect_to notebooks_url }
      format.json { head :no_content }
    end
  end
  def mobiledownload
   
    @notebookf=Notebook.all
    @notebookf.each do |notebook|
      
      notebook[:name]=(User.find(notebook.user_id)).name
    end
     @notebooks = {notebooks: @notebookf}
     respond_to do |format|
       format.json { render json: @notebooks }
     end
end
def mobileupload
   @correct={signin: false}
   puts " {  email: #{params[:email]} password: #{params[:password]}"
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
     @correct={signin: true}
     @notebook=Notebook.new
     @notebook.user_id=user.id
     @notebook.title=params[:title]
     @notebook.content=params[:content]
      @notebook.teacher=params[:teacher]
       @notebook.course=params[:course]
        @notebook.free=params[:free]
         @notebook.price=params[:price]
         @notebook.save!

    else
   @correct={signin: false}
   end
      respond_to do |format|
      format.json { render json: @correct }
    end
  end
end
