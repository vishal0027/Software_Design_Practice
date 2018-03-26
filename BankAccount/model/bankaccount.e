note
	description: "Summary description for {BANKACCOUNT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BANKACCOUNT


create   -- Explicitily declare the feature of constructor
	make

feature -- Attributes
	balance : INTEGER
	na : STRING


feature -- Constructor
	make (n : STRING; v : INTEGER)
	do
		balance := v
		na := n
	end

feature -- Withdraw method
	withdraw(amount : INTEGER)

	require -- Precondition
		balance > 0 and balance > amount
	do
		balance := balance - amount
	end

end
