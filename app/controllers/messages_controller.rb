class MessagesController < ApplicationController


  def create
    new_message = Message.new(message_params)
    new_message.messageable = return_user
    binding.pry
  end

  private

    def message_params
      params.require(:message).permit(:complaint_id, :text)
    end

    def return_user
      User.first
    end

end
