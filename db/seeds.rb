categories = [
  { :name => "tech", :description => "All things tech" },
  { :name => "bicycles", :description => "All things bicycles" }
]
Category.create(categories)

tags = [
  { :name => "cool" },
  { :name => "awesome" }
]
Tag.create(tags)

roles = [
  { :name => "admin" },
  { :name => "user" }
]
Role.create(roles)
