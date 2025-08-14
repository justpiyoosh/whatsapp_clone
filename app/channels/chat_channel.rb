class ChatChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "📡 ChatChannel subscribed to room: #{params[:room]}"
    Rails.logger.info "👤 User: #{current_user&.username || 'anonymous'}"
    stream_from "chat_#{params[:room]}"
  end

  def unsubscribed
    Rails.logger.info "📡 ChatChannel unsubscribed from room: #{params[:room]}"
  end

  def speak(data)
    Rails.logger.info "🗣️ ChatChannel speak called with data: #{data}"
    ActionCable.server.broadcast "chat_#{params[:room]}", {
      message: data["message"],
      sender: data["sender"],
      timestamp: Time.current.strftime("%H:%M")
    }
  end
end
