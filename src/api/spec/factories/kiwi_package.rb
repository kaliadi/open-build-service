FactoryGirl.define do
  factory :kiwi_package, class: Kiwi::Repository do
    association :package_group, factory: :kiwi_package_group

    name        { Faker::Cat.name }
    arch        { Faker::Cat.name }
    replaces    { Faker::Cat.name }
    bootinclude { Faker::Boolean.boolean(0.4) }
    bootdelete  { Faker::Boolean.boolean(0.2) }
  end
end
