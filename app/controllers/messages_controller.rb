class MessagesController < ApplicationController


  def create
    @message = Message.new(message_params)
    @message.messageable = return_user(@message)
    @complaint = @message.complaint
    if @message.save
      respond_to do |format|
        format.html { redirect_to complaints_find_path(:complaint_key => @complaint.key) }
        format.js {}
      end
    else
      @errors = @message.errors.full_messages
      respond_to do |format|
        format.html { render "complaints/show" }
        format.js { render "complaints/show" }
      end
    end
  end

  private

    def message_params
      params.require(:message).permit(:complaint_id, :text)
    end

    def return_user(new_message)
      creating_user = new_message.complaint.user
      current_investigator ? current_investigator : creating_user
    end

end
