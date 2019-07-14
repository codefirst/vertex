class Task < ActiveRecord::Base
  include RankedModel
  ranks :row_order, with_same: :user_id

  belongs_to :user
end
