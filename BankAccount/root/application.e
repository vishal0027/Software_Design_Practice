note
	description: "BankAccount application root class"
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
			k : BANKACCOUNT
		do
			--| Add your code here

			print ("Making Account!%N")
		--	create t.make ("Vishal", 100)
		--	print (t.na)
		--	print (t.balance)

		end

end
