-- The Linux kernel, the one and only

--[[
	Linux is built using an embedded initramfs
	built with the initrd material.
	It should provide us with a standalone init
	binary executable located into its build directory.
	The configuration's CONFIG_INITRAMFS_SOURCE file will
	provide the initrd.img root hierarchy structure.
--]]
local crucible, host, target = ...

local material = hex.melt(crucible, 'materials/kernel')

material.dependencies = { 'initrd' };

material.setup = {
	configure = {
		config = crucible.support.kernelconfig;
		target = 'olddefconfig';
	};
	build = { options = { '-j', host.cores } };
}

material.override = {
	install = function(name, material)
		hex.cast('make', '-C', material.source,
			'INSTALL_HDR_PATH='..fs.path('../..', material.build),
			'dir-pkg', 'headers_install')
		fs.copy(fs.path(material.source, 'tar-install'), material.build)
	end;
}
