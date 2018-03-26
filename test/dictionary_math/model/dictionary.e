note
	description: "A Dictionary ADT mapping from keys to values"
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	-- Constrained genericity because V and K will be used
	-- in the math model class FUN, which require both to be always
	-- attached for void safety.
	DICTIONARY[V -> attached ANY, K -> attached ANY]
inherit
	ITERABLE[TUPLE[V, K]]
create
	make

feature {NONE} -- Do not modify this export status!
	values: ARRAY[V]
	keys: LINKED_LIST[K]

feature -- Abstraction function
	model: REL[K, V] -- Do not modify the type of this query.
			-- Abstract the dictionary ADT as a mathematical function.
		do
			create Result.make_empty
			across
				1 |..| keys.count as i
			loop
				Result.extend (create {PAIR[K,V]}.make (keys.i_th (i.item), values.item (i.item)))
			end
		ensure
			consistent_model_imp_counts: model.count = keys.count and model.count =  values.count
				-- Your Task: sizes of model and implementations the same
			consistent_model_imp_contents:
				-- Your Task: applying the model Relation on each key gives back the corresponding value
				across
					1 |..| keys.count as i
				all
					Result.has (create {PAIR[K, V]}.make(keys.i_th (i.item), values.item (i.item)))
				end
		end

feature -- feature required by ITERABLE
	new_cursor: ITERATION_CURSOR[TUPLE[V, K]]
		do
			-- Your Task
			create {TUPLE_ITERATION_CURSOR[V,K]} Result.make (values, keys)
		end

feature -- Constructor
	make
			-- Initialize an empty dictionary.
		do
			create values.make_empty
			create keys.make
			values.compare_objects
			keys.compare_objects
			-- Your Task: add more code here
		ensure
			empty_model: model.is_empty
				-- Your task
			object_equality_for_keys:
				keys.object_comparison
			object_equality_for_values:
				values.object_comparison
		end

feature -- Commands

	add_entry (v : V; k : K)
		-- ADD IF KEY DOES'NT EXISTS AND REPLACE IF KEY EXISTS
		local
			i : INTEGER
		do
			if not keys.has (k) then
				values.force (v, values.count+1)
				keys.force (k)
			else
				from
					keys.start
				until
					keys.exhausted
				loop
					if k ~ keys.item then
						i := keys.index
					end
					keys.forth
				end
				values[i] := v
			end

			ensure
				entry_added_to_model : model.has (create {PAIR[K,V]}.make (k, v))
				other_unchanged :
					across
						model.domain as j
					all
						((j.item ~  k) implies (model.has (create {PAIR[K,V]}.make (k, v))))
						and
						((j.item /~ k) implies (model.has (create {PAIR[K,V]}.make (j.item, (old model.deep_twin).image (j.item).as_array.item(1)))))
					end
		end

	remove_entry (k: K)
		require
			existing_in_model: model.domain.has (k)
		local
					old_value : ARRAY[V]
					i : INTEGER
		do
			from
				keys.start
			until
				keys.exhausted
			loop
				 if (keys.item ~ k) then
				 	i :=  keys.index
				 	keys.remove
				 end
				 keys.forth
			end
			old_value := values.twin
			values.make_empty
			across
					1 |..| (i-1) as j
				loop
						 values.force (old_value[(j).item],(j).item)
				end
			across
					i |..| (old_value.count-1) as j
				loop
							 values.force (old_value[(j).item+1],((j).item))
				end

		ensure
			entry_removed_from_model: (not model.domain.has (k))
		end

feature -- Queries

	count: INTEGER
			-- Number of keys in BST.
		do
			-- Your Task
			Result := keys.count
		ensure
			correct_model_result: Result = model.count
		end

	get_keys (v: V): ITERABLE[K]
			-- Keys that are associated with value 'v'.
		local
			id : ARRAY[K]
		do
			create id.make_empty
			across
				1|..| values.count as j
			loop
				if v ~ values[j.item] then
				id.force (keys.at (j.item), id.count+1)
				end
			end
			Result := id
		ensure
			correct_model_result:
					 result ~ model.range_restricted_by (v).intersected(model).domain.as_array
		end

	get_value (k: K): detachable V
			-- Assocated value of 'k' if it exists.
			-- Void if 'k' does not exist.
	do
		from
			keys.start
		until
			keys.exhausted
		loop
			 if (keys.item ~ k) then
			 	Result := values[keys.index]
			 end
			 keys.forth
		end
	ensure
		case_of_void_result: (result = void) implies not(model.domain.has (k))
			-- Your Task: void result means the key does not exist in model
		case_of_non_void_result:
			across
				1 |..| keys.count as j
			all
				 (model.as_array[j.item].item (1) ~ k) implies	model.as_array[j.item].item (2) ~ Result

			end
	end

invariant
	consistent_keys_values_counts:
		keys.count = values.count
	consistent_imp_adt_counts:
		keys.count = count
end
