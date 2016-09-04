class MessagesController < ApplicationController


  def create
    new_message = Message.new(message_params)
    new_message.messageable = return_user(new_message)
    new_message.save
    redirect_to complaints_find_path(:complaint_key => new_message.complaint.key)
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
