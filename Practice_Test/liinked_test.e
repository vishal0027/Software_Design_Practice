note
	description: "Summary description for {LIINKED_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIINKED_TEST
create
	make
feature {NONE}
	imp : LINKED_LIST[STRING]
----------------------------------------
feature
	make
	do
		create imp.make
		ensure
			imp.count = 0
	end
----------------------------------------
feature
	insert_last (s : STRING)
		do
			imp.force (s)
			ensure
			size_changes:	imp.count = (old imp.count+1)
		end
----------------------------------------
end
