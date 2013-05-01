class AuditsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @audits = []
    Answer.all.each do |answer|
      @audits.concat(answer.audits)
    end
    @audits.sort_by! &:created_at
    @audits.reverse!
  end
end
