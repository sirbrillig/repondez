class Answer < ActiveRecord::Base
  attr_accessible :answer_text, :guest_id, :question_id
  belongs_to :guest
  belongs_to :question
  audited associated_with: :guest
end
