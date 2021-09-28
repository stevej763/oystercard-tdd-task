$count = 0
describe "let" do
  let(:count) { $count += 1 }
  let(:print_something) { puts "I have been called for the first time!"}

  let(:variable) { double("Hi") }

  it "memoizes the value" do
    count.should == 1
  end

  it "is not cached across examples" do
    count.should == 2
    puts variable
    puts count
    puts count
    puts count
    puts count
    puts count
    puts count
    puts count
    puts count
    puts count
    print_something
    print_something
    print_something
    print_something
    print_something
    print_something
  end

  it "is not cached across examples" do
    count.should == 3
    puts count
    print_something
    print_something
    print_something
    print_something
    print_something
    print_something
  end

  it "is not cached across examples" do
    count.should == 4
    puts count
    print_something
    print_something
    print_something
    print_something
    print_something
    print_something
  end

  it "is not cached across examples" do
    count.should == 5
    puts count
    print_something
    print_something
    print_something
    print_something
    print_something
    print_something
  end

  it "is not cached across examples" do
    count.should == 6
    puts count
    print_something
    print_something
    print_something
    print_something
    print_something
    print_something
  end
end