# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    task_type 'feature'
    status 'unstarted'
    point 0
    title 'title1'
    description 'description'
  end
end
