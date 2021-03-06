class ChatroomPolicy < ApplicationPolicy
  def index?
    own_chatroom?
  end

  def show?
    user_is_in_chat?
  end

  def create?
    true
  end

  def update?
    user_is_in_chat?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private
  def own_chatroom?
    record.each { |rec| rec.messages.find_by(sender: user) || rec.messages.find_by(receiver: user) }
  end

  def user_is_in_chat?
    record.messages.find_by(sender: user) || record.messages.find_by(receiver: user)
  end
end
