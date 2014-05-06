class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
        can :manage, :all
    elsif user.role? :instructor
        can :update, Instructor do |instructor|  
        instructor.id == user.instructor_id
        end
        can :destroy, Instructor do |instructor|  
        instructor.id == user.instructor_id
        end
        # they can read their own profile
        can :show, User do |u|  
        u.id == user.id
        end
        # they can update their own profile
        can :update, User do |u|  
        u.id == user.id
        end
        # # they can read their own camps' data
        # can :read, Camp do |this_camp|  
        # my_camps = user.instructor.camps.map(&:id)
        # my_camps.include? this_camp.id 
        # end  
        # # they can update the camp only if they are the administrator
        # can :update, Camp do |this_camp|
        # managed_camps = user.instructor.camps.map{|p| p.id if p.user_id == "Administrator"}
        # managed_camps.include? this_camp.id
        # end      
        # they can read information of students in their camps
        can :read, Student do |this_student|  
        camp_students = user.instructor.camps.map{|p| p.students.map(&:id)}.flatten
        camp_students.include? this_student.id 
        end
        # they can update information of students in their camps
        can :update, Student do |this_student|  
        camp_students = user.instructor.camps.map{|p| p.students.map(&:id)}.flatten
        camp_students.include? this_student.id 
        end   
        # they can create new students in their camps
        can :create, Student do |this_student|  
        camp_students = user.instructor.camps.map{|p| p.students.map(&:id)}.flatten
        camp_students.include? this_student.id  
        end
    # elsif user.role? :member
    #     can :update, Band do |band|  
    #     band.id == user.band_id
    # end
    else
        can :read, :all
    end
  end
    # 
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
