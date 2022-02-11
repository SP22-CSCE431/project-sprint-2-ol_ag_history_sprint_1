class WikiPolicy < ApplicationPolicy
    # our authorization rules will go here
    def create?
        if member.admin
    end
end