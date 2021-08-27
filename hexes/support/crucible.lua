--[[ curcible
	The crucible is the worktree for all out-of-source rituals.
	It supports logging and minimal isolation.
	It is the right place to create artifacts and configure build files.
--]]
local host, target = ...

local crucible = hex.crucible('forge-'..triple(target))

--[[
	Hide user id from build process.
	Redirect output to 'outputs' directory.
--]]
crucible.shackle = {
	user = { uid = 0; gid = 0 };
	outputs = fs.path(crucible.molten, 'outputs');
}

--[[
	Add new support attribute to expose target-specific
	generated configurations and files to be located in 'support'.
--]]
local support = fs.path(crucible.molten, 'support')

crucible.support = {
	cmaketoolchain = fs.path(support, 'toolchain.cmake');
	kernelconfig = fs.path(support, 'kernel-config');
}

-- Creating support directory and preprocessing support files.
fs.mkdirs(support)

hex.preprocess('support/toolchain.cmake.in', crucible.support.cmaketoolchain, {
	CC = host.compilers.C;
})

local initramfs_source = fs.path(support, 'kernel-initramfs')
hex.preprocess('support/kernel-initramfs.in', initramfs_source, {
	MOLTEN = crucible.molten;
})

hex.preprocess('support/kernel-config.in', crucible.support.kernelconfig, {
	DEFAULT_HOSTNAME = 'heylelos';
	INITRAMFS_SOURCE = initramfs_source;
})

return crucible
