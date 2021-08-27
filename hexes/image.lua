-- HeylelOS image builder

log.level = 'debug'

local host     = hex.dofile('hexes/support/host.lua')
local target   = hex.dofile('hexes/support/target.lua')
local crucible = hex.dofile('hexes/support/crucible.lua', host, target)

hex.dofile('hexes/materials/initrd.lua', crucible, host, target)
hex.dofile('hexes/materials/kernel.lua', crucible, host, target)

log.info('Performing sequence for target ', triple(target))
hex.perform(crucible, 'configure', 'build', 'install')

