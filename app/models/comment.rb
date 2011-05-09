class Comment < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :commentable, :polymorphic => :true
  belongs_to :user

  def ago
    time_ago_in_words updated_at
  end
end
