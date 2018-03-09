note
	description: "container application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CONTAINERS

inherit
	ES_SUITE

create
	make

feature -- Adding test classes.

	make
			-- Run application.
		local
			ac: ARRAYED_CONTAINER
		do
			add_test (create {TEST_DELETE_AT}.make)
			add_test (create {TEST_INSERT_AT}.make)
			add_test (create {TEST_INTSERT_LAST}.make)
			add_test (create {TEST_REMOVE_FIRST}.make)
			add_test (create {TEST_ASSIGN_AT}.make)

			add_test (create {TEST_ARRAYED_CONTAINER}.make)
			add_test (create {TEST_ARRAY_COPIES}.make)

			show_browser
			run_espec
		end

end
