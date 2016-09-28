require "cowsay"
require_relative "../uploaders/media_uploader"

class ComplaintsController < ApplicationController
  before_action :authenticate_investigator!, except: [:new, :show, :create, :advice]
  skip_before_action :verify_authenticity_token, :only => :create
  before_filter :cors_preflight_check, :only => :create

  def index
    # this cleanup is disabled by default -- enable it here AND in the Complaint model
    # Complaint.run_cleanup
    @complaints = Complaint.all.order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @complaint = Complaint.new
  end

  def create
    @message = Message.new
    @complaint = Complaint.new(complaint_params)
    @complaint.user = return_user
    if params[:complaint][:video_links]
      params[:complaint][:video_links].each do |n, l|
        @complaint.video_links << VideoLink.create(url: l) unless l == ""
      end
    end

    if @complaint.save
      respond_to do |format|
        format.js do
          render json: @complaint, content_type: "application/json"
          1500.times {puts "Clear logs"}
        end

        format.html do
          # add 303 redirect here to a new flash page?
          # redirect_to :action=> ???, :status => 303
          flash[:comp_key] = @complaint.key
          flash[:comp_pin] = @complaint.pin
          flash[:comp_message] = @complaint.content
          session[:complaint_pin] = @complaint.pin
          redirect_to complaints_show_path(:complaint_key => @complaint.key), :status => 303
          1500.times {puts "Clear logs"}
        end
      end

    else

      @errors = @complaint.errors.full_messages
      render "new"
    end
  end

  def show

    if !params[:complaint_pin] && !session[:complaint_pin] && !current_investigator
      render "show_pinprompt"
    else
      @message = Message.new

      pin = params[:complaint_pin] ? params[:complaint_pin] : session[:complaint_pin]
      session[:complaint_pin] = nil

      pin = Complaint.find_by(key: params[:complaint_key]).pin if current_investigator

      @complaint = @complaint ? @complaint : Complaint.find_by(key: params[:complaint_key], pin: pin)
      if !@complaint
        redirect_to custom_errors_no_match_path
      else
        @messages = @complaint.messages.order("created_at DESC").page(params[:page]).per(10)
        @complaint.messages.each {|m| m.update_attribute(:viewed, true)}
        1500.times {puts "Clear logs"} if !current_investigator
      end
    end

  end

  def edit
    @complaint = Complaint.find_by(key: params[:complaint_key])
  end

  def update
    @complaint = Complaint.find_by(key: params[:complaint_key])
    @complaint.update_attribute(:status, params[:status])
    respond_to do |format|
      format.js {render json: @complaint, status_code: "200"}
      format.html {redirect_to complaints_path}
    end
  end

  def destroy
    complaint = Complaint.find_by(key: params[:complaint_key])
    complaint.destroy
    redirect_to '/complaints'
  end

  def download
    @complaint = Complaint.find_by(key: params[:complaint_key])
    file = @complaint.zip_media
    File.open(file, 'r') do |f|
      send_data f.read, type: "application/zip", filename: file
    end
    FileUtils.rm(file)
  end

  def podio_export
    @complaint = Complaint.find_by(id: params[:id])
    @message = Message.new
    if @complaint.exists_in_podio?
      @errors = ["This complaint/tip has already been sent to Podio"]
    else
      @complaint.update_attribute(:status, "Initiated-Investigation")
      @complaint.export_to_podio

      respond_to do |format|
        format.html { redirect_to(:back) }
        format.js {}
      end
    end
  end

  def advice
    # render 'advice'
  end


  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*' #needs to get set to origin for form
    headers['Access-Control-Allow-Methods'] = 'POST'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end


  private

    def complaint_params
      params.require(:complaint).permit(:content, {media: []}, :video_links_array)
    end

    def return_user
      up = user_params[:user]
      User.find_or_create_by(up)
    end

    def user_params
      params.require(:complaint).permit(user: [:name, :email, :phone])
    end

    def complaint_by_key_and_pin(params, flash)
      Complaint.find_by(key: params[:complaint_key], pin: params[:complaint_pin])
    end

end
