local http = require("coro-http")
local url = require("../utils/url.lua")
local json = require("json")

local soundcloud = {
	clientId = nil,
	baseUrl = "https://api-v2.soundcloud.com",
}

function soundcloud.init()
	print("[soundcloud]: Setting up clientId for fetch tracks...")
	local _, mainsite_body = http.request("GET", "https://soundcloud.com/")
	if mainsite_body == nil then
		return soundcloud.fetchFailed()
	end

	local assetId =
		string.gmatch(
			mainsite_body,
			"https://a%-v2%.sndcdn%.com/assets/[^%s]+%.js"
		)
	if assetId() == nil then
		return soundcloud.fetchFailed()
	end

	local call_time = 0
	while call_time < 4 do
		assetId()
		call_time = call_time + 1
	end

	local _, data_body = http.request("GET", assetId())
	if data_body == nil then
		return soundcloud.fetchFailed()
	end

	local matched = data_body:match("client_id=[^%s]+")
	if matched == nil then
		return soundcloud.fetchFailed()
	end
	local clientId = matched:sub(11, 41 - matched:len())
	soundcloud["clientId"] = clientId
	print("[soundcloud]: Setting up clientId for fetch tracks successfully")
end

function soundcloud.fetchFailed()
	print("[soundcloud]: Failed to fetch clientId.")
end

function soundcloud.search(query)
	local query_link =
		soundcloud.baseUrl .. "/search" .. "?q=" .. url.encode(
			query
		) .. "&variant_ids=" .. "&facet=model" .. "&user_id=992000-167630-994991-450103" .. "&client_id=" .. soundcloud.clientId .. "&limit=" .. "20" .. "&offset=0" .. "&linked_partitioning=1" .. "&app_version=1679652891" .. "&app_locale=en"

	local response, res_body = http.request("GET", query_link)
	if response.code ~= 200 then
		return nil, "Server response error: " .. response.code
	end
	local decoded = json.decode(res_body)
	local res = {}
	local counter = 1

	for _, value in pairs(decoded.collection) do
		if value.kind ~= "track" then
		else
			res[counter] = soundcloud.buildTrack(value)
			counter = counter + 1
		end
	end

	return res, nil
end

function soundcloud.buildTrack(data)
	local isrc = nil
	if type(data.publisher_metadata) == "table" then
		isrc = data.publisher_metadata.isrc
	end

	return {
		info = {
			title = data.title,
			author = data.user.permalink,
			identifier = data.id,
			uri = data.permalink_url,
			is_stream = false,
			is_seekable = true,
			source_name = "soundcloud",
			isrc = isrc,
			artwork_url = data.artwork_url,
			length = data.full_duration,
		},
	}
end

-- soundcloud:init()
-- local res = soundcloud:search("Childish Gambino - Redbone")
-- require("../utils/print_table.lua")(res)

return soundcloud