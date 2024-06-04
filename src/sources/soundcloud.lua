local http = require("coro-http")
local url = require("../utils/url.lua")
local mod_table = require("../utils/mod_table.lua")
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
		soundcloud.baseUrl
		.. "/search"
		.. "?q=" .. url.encode(query)
		.. "&variant_ids="
		.. "&facet=model"
		.. "&user_id=992000-167630-994991-450103"
		.. "&client_id=" .. soundcloud.clientId
		.. "&limit=" .. "20"
		.. "&offset=0"
		.. "&linked_partitioning=1"
		.. "&app_version=1679652891"
		.. "&app_locale=en"

	local response, res_body = http.request("GET", query_link)
	if response.code ~= 200 then
		return {
			loadType = "error",
			tracks = {},
			message = "Server response error: " .. response.code
		}, nil
	end
	local decoded = json.decode(res_body)

	if #decoded.collection == 0 then
		return {
			loadType = "empty",
			tracks = { nil }
		}
	end

	local res = {}
	local counter = 1

	for _, value in pairs(decoded.collection) do
		if value.kind ~= "track" then
		else
			res[counter] = soundcloud.buildTrack(value)
			counter = counter + 1
		end
	end

	return {
		loadType = "search",
		tracks = res
	}
end

function soundcloud.loadForm(query)
	local query_link =
		soundcloud.baseUrl
		.. "/resolve"
		.. "?url=" .. url.encode(query)
		.. "&client_id=" .. url.encode(soundcloud.clientId)

	local response, res_body = http.request("GET", query_link)
	if response.code ~= 200 then
		return {
			loadType = "error",
			tracks = {},
			message = "Server response error: " .. response.code
		}, nil
	end

	local body = json.decode(res_body)

	if body.kind == "track" then
		return {
			loadType = "track",
			tracks = { soundcloud.buildTrack(body) },
		}
	elseif body.kind == "playlist" then
		local loaded = {}
		local unloaded = {}

		for _, raw in pairs(body.tracks) do
			if not raw.title then
				unloaded[#unloaded + 1] = tostring(raw.id)
			else
				loaded[#loaded + 1] = soundcloud.buildTrack(raw)
			end
		end

		local playlist_stop = false
		local is_one = false

		while playlist_stop == false do
			if is_one then break end
			local notLoadedLimited
			local filtered

			if #unloaded > 50 then
				notLoadedLimited = mod_table.split(unloaded, 1, 50)
				filtered = mod_table.split(unloaded, 50, #unloaded)
			elseif #unloaded == 1 then
				notLoadedLimited = { unloaded[1] }
				filtered = nil
			else
				notLoadedLimited = mod_table.split(unloaded, 1, #unloaded)
				filtered = mod_table.split(unloaded, #unloaded, #unloaded)
			end

			local unloaded_query_link =
				soundcloud.baseUrl
				.. "/tracks"
				.. "?ids=" .. soundcloud.merge(notLoadedLimited)
				.. "&client_id=" .. url.encode(soundcloud.clientId)
			local unloaded_response, unloaded_res_body = http.request("GET", unloaded_query_link)
			if unloaded_response.code == 200 then
				local unloaded_body = json.decode(unloaded_res_body)
				for key, raw in pairs(unloaded_body) do
					loaded[#loaded + 1] = soundcloud.buildTrack(raw)
					unloaded_body[key] = nil
				end
			else end
			if filtered == nil then playlist_stop = true
			elseif #filtered == 0 then playlist_stop = true
			else unloaded = filtered end
			if #unloaded == 1 then is_one = true end
		end

		return {
			loadType = 'playlist',
			info = {
				name = body.title,
				selectedTrack = 0,
			},
			tracks = loaded,
		}
	end

	return {
		loadType = "empty",
    tracks = { nil },
  }
end

function soundcloud.isLinkMatch(query)
	local check1 = query:match("https?://www%.soundcloud%.com/[^%s]+/[^%s]+")
	local check2 = query:match("https?://soundcloud%.com/[^%s]+/[^%s]+")
	local check3 = query:match("https?://m%.soundcloud%.com/[^%s]+/[^%s]+")
	if check1 or check2 or check3 then return true end
	return false
end

function soundcloud.merge(unloaded)
	local res = ""

	for i = 1, #unloaded do
		res = res .. unloaded[i]
		if i ~= #unloaded then
			res = res .. "%2C"
		end
	end

	return res
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