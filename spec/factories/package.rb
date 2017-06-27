FactoryGirl.define do
  factory :st_package, class: OpenStruct do
    packages = [
      {
        title: :free,
        price: 0,
        discount: 100
      },{
        title: :basic,
        price: 50,
        discount: 25
      },{
        title: :premium,
        price: 199.9,
        discount: 0
      },{
        title: :platinum,
        price: 0,
        discount: 0
      }
    ]
    attr = Proc.new do |name, num|
      cycle = packages.cycle.each
      (num - 1).times { cycle.next }
      cycle.peek[name]
    end
    %i(title price discount).each do |attr_name|
      sequence(attr_name) { |n| attr.call(attr_name, n) }
    end
    sequence(:priority) { |n| n }
  end
end