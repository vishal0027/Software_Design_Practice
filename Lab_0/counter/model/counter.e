note
	description: "Summary description for {COUNTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COUNTER

create   -- Explicitily declare the feature of constructor
	make

feature -- Attributes: counter value
	value : INTEGER

feature -- Constructor
	make (v : INTEGER)
		-- Intialize value of counter with some value 'v'
	do
		value := v
	end

feature -- Increment function
	increment_by (v: INTEGER)
		-- Increment value by 'v'.
	require -- Precondition
		not_above_max : value + v <=10
	do
		value := value + v
		ensure -- Post Condition for the increment function
			value_incremented : value = old value + v
	end

feature -- Decrement function
	decrement_by (v : INTEGER)
		-- Decrement value by 'v'
	require
			not_below_min: value - v >= 0
		do
			value := value - v
		ensure
			value_decremented: value = old value - v
		end
invariant -- Class invariant
	counter_in_range:
	0<= value and value <= 10
end
