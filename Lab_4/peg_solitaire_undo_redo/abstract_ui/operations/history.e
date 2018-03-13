note
	description: "A history of executed commands."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY

create
	make

feature {SOLITAIRE_USER_INTERFACE}
	make
		do
			-- Hint. Consider instantiating the history
			-- using an ARRAYED_LIST.
			history := create {ARRAYED_LIST[COMMAND]}.make (0)
		end

feature -- history
	history: LIST[COMMAND]

	extend_history(new_cmd: COMMAND)
			-- Remove all operations to the right of the current
			-- cursor to history, then extend with the new command.
		do
			remove_right
			history.extend (new_cmd)
			history.forth
		ensure
			new_cmd_islast : history.at (history.count) ~ new_cmd
		end

	remove_right
			--Remove all elements to the right of the current cursor in history.
		local
			temp : ARRAYED_LIST[COMMAND]
		do
			--Creating a new copy of current History till current index
			create temp.make (0)
			across
				history.lower|..| history.index as j
			loop
				temp.extend (history.at (j.item))
			end
			------------
			temp.go_i_th (history.index)
			history := temp
		end

	item: COMMAND
			-- Item at the current cursor position.
		do
			Result := history.item
		end

	on_item: BOOLEAN
			-- Is cursor at a valid position?
		do
			Result := history.valid_index (history.index)
		end

	forth
			-- Move the cursor forward.
		do
			history.forth
		end

	back
			-- Move the cursor backward.
		do
			history.back
		end

	is_empty: BOOLEAN
			-- Is there at least one command in the history?
		do
			Result := history.is_empty
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			Result := history.islast  or history.is_empty
		end

end
