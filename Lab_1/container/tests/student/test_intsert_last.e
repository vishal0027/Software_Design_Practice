note
	description: "Summary description for {TEST_INTSERT_LAST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTSERT_LAST

inherit
	ES_TEST
create
	make

feature --- Testing Assign_At method in Array_container

	make			--- Testing
	do
		add_boolean_case(agent test_assign_at)
	end

feature -- Test_by Failure
	test_assign_at: BOOLEAN
		local
			ac : ARRAYED_CONTAINER
		 do
			comment ("Test assign at position") create ac.make
			 ac.insert_last ("alan")
			 ac.insert_last ("mark")
			 ac.insert_last ("tom")
			Result := ac.get_at (1) ~ "alan"  and ac.get_at (2) ~ "mark"and ac.get_at (3) ~ "tom"
	   		check Result end

		end
end
