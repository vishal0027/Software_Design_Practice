note
	description: "Summary description for {A}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A
create {A_ACCESS}
	make
feature {A_ACCESS}
	make
	do
		i := 10
	end
feature
	i : INTEGER
	change_i (ni : INTEGER)
	do
		i := ni
	end
end
