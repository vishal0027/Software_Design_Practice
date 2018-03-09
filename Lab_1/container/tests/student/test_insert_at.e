note
	description: "Summary description for {TEST_INSERT_AT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INSERT_AT
inherit
	ES_TEST
create
	make

feature --- Testing Assign_At method in Array_container

	make			--- Testing
	do
		add_boolean_case(agent test_insert_at)
	end

feature -- Test_by Failure

	test_insert_at:BOOLEAN
		local
			ac1: ARRAYED_CONTAINER
			do
				comment("TEST Insert at possition")
				create ac1.make
				ac1.insert_last ("alan")
			 	ac1.insert_last ("mark")
			 	ac1.insert_last ("tom")
			 	ac1.insert_last ("full")
			 	ac1.insert_last ("herry")
			 	ac1.insert_last ("pol")
				Result := ac1.get_at (1) ~ "alan"  and ac1.get_at(2) ~ "mark"and ac1.get_at (3) ~ "tom"
	   			check Result end
	   			ac1.insert_at (3, "vishal")
	   			Result := ac1.get_at (1) ~ "alan"  and ac1.get_at(2) ~ "mark" and ac1.get_at (3) ~ "vishal" -- and ac1.get_at (4) ~ "tom" and ac1.get_at (5) ~ "full"
	   			check Result end
			end


end
