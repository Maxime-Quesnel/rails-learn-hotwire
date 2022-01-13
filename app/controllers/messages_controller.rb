class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @message = Message.new
  end

  def create
    @message = Message.create(content: params['message']['content'])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append(:message, partial: 'messages/message', locals: { message: @message })
      end

      format.html { redirect_to messages_url }
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@message) }
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
