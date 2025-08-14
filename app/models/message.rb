class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  
  validates :content, presence: true, length: { maximum: 1000 }
  validates :sender, presence: true
  validates :recipient, presence: true
  
  scope :recent, -> { order(created_at: :desc) }
  
  def self.between_users(user1, user2)
    where(sender: user1, recipient: user2)
      .or(where(sender: user2, recipient: user1))
      .order(:created_at)
  end
end
