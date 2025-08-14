class User < ApplicationRecord
  has_secure_password
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  def messages_with(user)
    Message.where(sender: self, recipient: user)
           .or(Message.where(sender: user, recipient: self))
           .order(:created_at)
  end
end
