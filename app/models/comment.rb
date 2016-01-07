class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  has_many :votes, as: :votable

  validates :content, presence: true

  def likes_count
    # votes.length
    # votes.count
    votes.size
  end

  def liked_by!(user)
    # create a new vote associating user and photo
    raise "Already liked" if liked_by?(user)
    votes.where(voter: user).create!
  end

  def unliked_by!(user)
    raise "Not yet liked" unless liked_by?(user)
    votes.where(voter: user).first.destroy
  end

  def liked_by?(user)
    votes.exists?(voter: user)
  end

  def has_likes?
    !votes.empty?
  end 

end
