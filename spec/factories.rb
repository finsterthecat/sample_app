Factory.define :admin_user, :class => "User" do |user|
  user.name "Tony Brouwer"
  user.email "admin@railstutorial.org"
  user.password "foobar"
  user.password_confirmation "foobar"
  user.admin true
end

Factory.define :user do |user|
  user.name "Tony Brouwer"
  user.email "xxxxxexample@railstutorial.org"
  user.password "foobar"
  user.password_confirmation "foobar"
  user.admin false
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo Bar"
  micropost.association :user
end


