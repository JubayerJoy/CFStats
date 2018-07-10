module Updater

	include Parser

	# Makes an API request to Codeforces to update a handle information
	def update_user_info (handle)
		@info_handle = build_result(handle)
		db_entry = UserInformation.where(handle: handle.downcase)[0]
		db_entry.info = @info_handle
		db_entry.updates = db_entry.updates + 1
		db_entry.save
	end

	# Checks whether information for user exists or not and sets it up
	# Returns info of the comparison, info for handle 1 and infor for handle 2
	def set_up_result (handle1, handle2)
		db_entry_1 = UserInformation.where(handle: handle1.downcase)[0]
		db_entry_2 = UserInformation.where(handle: handle2.downcase)[0]
		if db_entry_1 == nil
			puts("Calling API for Handle 1 request")
			@info_handle_1 = build_result(handle1)
			UserInformation.create(:handle => handle1.downcase, :info => @info_handle_1, :updates => 1)
		else
			@info_handle_1 = db_entry_1.info
		end
		if db_entry_2 == nil
			puts("Calling API for Handle 2 request")
			@info_handle_2 = build_result(handle2)
			UserInformation.create(:handle => handle2.downcase, :info => @info_handle_2, :updates => 1)
		else
			@info_handle_2 = db_entry_2.info
		end
		@info_handle_1['updatedAt'] = UserInformation.where(handle: handle1.downcase)[0].updated_at
		@info_handle_2['updatedAt'] = UserInformation.where(handle: handle2.downcase)[0].updated_at
		@info = build_comparison(@info_handle_1, @info_handle_2)
		return @info, @info_handle_1, @info_handle_2
	end

end