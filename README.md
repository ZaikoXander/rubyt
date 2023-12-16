# RubyT

<div>
  <img src=".github/images/rubyt.png" alt="RubyT logo" width="250" height="250">
  RubyT is a Ruby gem that provides a set of types for Ruby programming.
</div>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubyt'
```

And then execute:

```sh
$ bundle install
```

## Usage

```ruby
require 'rubyt'

# Define a integer type
int = IntegerT.new(1)
int.t = 2
~ int.t = true # => RubytTypeError<Expected Integer but got TrueClass instead>
int = true
~ IntegerT.t int # => RubytTypeError<Expected IntegerT but got TrueClass instead>

# Define a array type
arr = ArrayT.new([1, 2, 3]) # Array of any type
arr = ArrayT.of(IntegerT).new([1, 2, 3]) # Array of IntegerT
arr.t = [1, 2, 3]
~ arr.t = [1, 2, true] # => RubytTypeError<Expected ArrayT of IntegerT but got Array of Integer and TrueClass instead>
arr = [1, 2, true]
~ ArrayT.of(IntegerT).t arr # => RubytTypeError<Expected ArrayT of IntegerT but got Array of Integer and TrueClass instead>

# Define a type variable
int_str_arr_t = ArrayT.of(IntegerT, StringT)
int_str_arr = int_str_arr_t.new([1, '2'])
~ int_str_arr.t = [{}, true] # => RubytTypeError<Expected ArrayT of IntegerT and StringT but got Array of Hash and TrueClass instead>

# Define a hash type
hash = HashT.new({ a: 1, b: 2 }) # Hash of any type
hash_of_integer_values = HashT.of(IntegerT).new({ a: 1, b: 2 }) # Hash of IntegerT
hash_of_multiple_types = HashT.of(IntegerT, StringT).new({ a: 1, b: '2' }) # Hash of IntegerT and StringT
hash_of_custom_values = HashT.of({ a: IntegerT, b: StringT }).new({ a: 1, b: '2' }) # Hash of custom types
hash_of_multiple_values = HashT.of({ a: IntegerT, b: StringT }, { c: IntegerT, d: StringT }).new({ a: 1, b: '2', c: 3, d: '4' }) # Hash of multiple custom types

# Must

test_var = 3
test_var.must
test_var = nil
test_var.must # => RubytMustNotBeNilError<must not be nil>
test_var.must('test_var must not be nil, never!') # => RubytMustNotBeNilError<test_var must not be nil, never!>

# Must not

test_var = 7
# must_not
test_var.must.not # => RubytMustBeNilError<must be nil>
test_var.must.not('test_var must be nil, ever!') # => RubytMustBeNilError<test_var must be nil, ever!>

# Must be a

test_var = IntegerT.new 3
# must_be_a
test_var.must.be_a(IntegerT)

# Define a function

def sum(a, b)
  IntegerT.t(a, b)

  return_t = ->(r) { IntegerT.t r }
  # or ~ def return_t(r) = IntegerT.t r

  sum = IntegerT.new(a.t + b.t)

  return_t.call sum
  # ~ return_t sum
end

```