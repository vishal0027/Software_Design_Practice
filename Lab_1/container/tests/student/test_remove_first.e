note
	description: "Summary description for {TEST_REMOVE_FIRST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_REMOVE_FIRST

inherit
	ES_TEST
create
	make

feature --- Testing Assign_At method in Array_container

	make			--- Testing
	do


		add_boolean_case(agent test_Remove_first)

	end

feature -- Test_by Failure
	test_Remove_first:BOOLEAN
		local
			ac2: ARRAYED_CONTAINER
			do
				comment("TEST Remove_First")
				create ac2.make
				ac2.insert_last ("alan")
			 	ac2.insert_last ("mark")
			 	ac2.insert_last ("tom")
			 	ac2.insert_last ("full")
			 	ac2.insert_last ("herry")
			 	ac2.insert_last ("pol")
				Result := ac2.get_at (1) ~ "alan"  and ac2.get_at(2) ~ "mark"and ac2.get_at (3) ~ "tom"
	   			check Result end
	   			ac2.remove_first
	   			Result := ac2.get_at (1) ~ "mark"  and ac2.get_at(2) ~ "tom"
	   			check Result end
			end

end
