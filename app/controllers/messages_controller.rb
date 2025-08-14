class MessagesController < ApplicationController
  before_action :require_login
  before_action :set_recipient, only: [ :index, :create ]

  def index
    @messages = Message.between_users(current_user, @recipient)
    @users = User.where.not(id: current_user.id)

    # Redirect if no other users exist
    if @users.empty?
      redirect_to root_path, alert: "No other users available for chat"
      nil
    end
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    @message.recipient = @recipient

    if @message.save
      # Broadcast to the specific chat room
      chat_room = chat_room_id
      Rails.logger.info "📡 Broadcasting message to chat_#{chat_room}"
      Rails.logger.info "📨 Message: #{@message.content} from #{current_user.username} to #{@recipient.username}"

      # Test broadcast to verify Action Cable is working
      ActionCable.server.broadcast "chat_#{chat_room}", {
        message: @message.content,
        sender: current_user.username,
        timestamp: @message.created_at.strftime("%H:%M")
      }

      # Also broadcast a test message to verify the channel is working
      ActionCable.server.broadcast "chat_#{chat_room}", {
        message: "TEST: Action Cable is working!",
        sender: "SYSTEM",
        timestamp: Time.current.strftime("%H:%M")
      }

      Rails.logger.info "✅ Message broadcasted successfully"
      head :ok
    else
      Rails.logger.error "❌ Failed to save message: #{@message.errors.full_messages}"
      render json: { error: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def test_broadcast
    chat_room = chat_room_id
    Rails.logger.info "🧪 Testing broadcast to chat_#{chat_room}"

    ActionCable.server.broadcast "chat_#{chat_room}", {
      message: "Manual test message at #{Time.current.strftime('%H:%M:%S')}",
      sender: "TEST",
      timestamp: Time.current.strftime("%H:%M")
    }

    render json: { status: "Test message sent to chat_#{chat_room}" }
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_recipient
    if params[:recipient_username]
      @recipient = User.find_by(username: params[:recipient_username])
    elsif params[:message] && params[:message][:recipient_username]
      @recipient = User.find_by(username: params[:message][:recipient_username])
    else
      # Default to first other user
      @recipient = User.where.not(id: current_user.id).first
    end

    unless @recipient
      redirect_to root_path, alert: "No users available for chat"
    end
  end

  def chat_room_id
    room_id = [ current_user.id, @recipient.id ].sort.join("_")
    Rails.logger.info "🏠 Chat room ID: #{room_id} (users: #{current_user.id}, #{@recipient.id})"
    room_id
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "Please log in to continue"
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
