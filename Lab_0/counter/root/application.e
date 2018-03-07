note
	description: "counter application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
			local
			t: COUNTER

		do
			--| Add your code here
			print ("Hello Eiffel World @ EECS3311!%N")
			create t.make (8)

			print ("goodbye %N")
			print(t.value)

		end

end
