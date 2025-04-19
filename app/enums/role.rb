# -*- encoding : utf-8 -*-
class Role < ClassyEnum::Base
end

class Role::Admin < Role
end

class Role::Member < Role
end

class Role::EnvironmentAdmin < Role
end

class Role::Teacher < Role
end

class Role::Tutor < Role
end

def visit_Role_Admin(role, _attribute)
  "'admin'"
end

def visit_Role_Member(role, _attribute)
  "'member'"
end

def visit_Role_EnvironmentAdmin(role, _attribute)
  "'environment_admin'"
end

def visit_Role_Teacher(role, _attribute)
  "'teacher'"
end

def visit_Role_Tutor(role, _attribute)
  "'tutor'"
end
