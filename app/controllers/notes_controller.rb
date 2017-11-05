class NotesController < ApplicationController
protect_from_forgery with: :null_session
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
	def note_json
		@newurl=SecureRandom.urlsafe_base64(32)
		if request.content_type =~ /xml/
		@text = Nokogiri::XML(request.body.read).xpath('/message').children[0].to_s
		@note = Note.new({msg:@text, url:@newurl})
		@note.save
		@newurl =request.base_url+ "/show_note/" + @note.url
		respond_to do |format| 
        		format.xml {render xml: "<?xml version='1.0' encoding='UTF-8'?> <url> #{@newurl} </url>"}
      		end
		else 	
		@note = Note.new({msg:params[:message], url:@newurl})
		@note.save
		@newurl =request.base_url+ "/show_note/" + @note.url
		respond_to do |format| 
        		format.json {render json: {'url' => @newurl}}
      		end
		end
	end
  	def newNote
		@newurl=SecureRandom.urlsafe_base64(32)
		@note = Note.new({msg:params[:the_note], url:@newurl})
		@note.save
		@newurl =request.base_url+ "/show_note/" + @note.url
		
		render "your_url"

	end
	def printNote
		@note = Note.find_by url:params[:id]
		
		@help = ""
		if @note == nil 
			@help = "No such note....sorry mate"
		else 
			@help = @note.msg
			@note.destroy
		end
		render "your_note"
	end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:msg, :url)
    end
end
