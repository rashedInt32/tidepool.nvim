-- Tidepool demo: Lua
-- TODO: replace the in-memory cache with an LRU

local M = {}

---@class Tide
---@field name string
---@field height number
---@field rising boolean

local MAX_HEIGHT = 4.2
local cache = setmetatable({}, { __mode = "k" })

--- Build a tide record.
---@param name string
---@param height? number
---@return Tide
function M.new(name, height)
  height = height or 0
  assert(type(name) == "string", "name must be a string")
  return { name = name, height = math.min(height, MAX_HEIGHT), rising = true }
end

local function describe(tide)
  local state = tide.rising and "rising" or "falling"
  return string.format("%s is %s at %.1fm", tide.name, state, tide.height)
end

function M.report(tides)
  local lines = {}
  for i, tide in ipairs(tides) do
    if cache[tide] == nil then
      cache[tide] = describe(tide)
    end
    lines[#lines + 1] = ("%d. %s"):format(i, cache[tide])
  end
  return table.concat(lines, "\n")
end

local ok, err = pcall(function()
  local pools = { M.new("north", 1.5), M.new("south", 9) }
  vim.notify(M.report(pools), vim.log.levels.INFO)
end)

if not ok then
  error("report failed: " .. tostring(err)) -- FIXME: surface to user
end

return M
