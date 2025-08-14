module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      Rails.logger.info "🔌 ActionCable connection attempt"
      self.current_user = find_verified_user
      Rails.logger.info "✅ ActionCable connected for user: #{current_user&.username || 'anonymous'}"
    end

    private

    def find_verified_user
      if verified_user = User.find_by(id: session[:user_id])
        Rails.logger.info "👤 Found verified user: #{verified_user.username}"
        verified_user
      else
        Rails.logger.info "👤 No verified user found, allowing anonymous connection"
        nil
      end
    end

    def session
      @session ||= cookies.encrypted[Rails.application.config.session_options[:key]]
    end
  end
end
