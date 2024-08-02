{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
			extraConfigLuaPost = ''
				local dap, dapui = require("dap"), require("dapui")

				dap.adapters.gdb = {
					type = "executable",
					command = "gdb",
					args = { "-i", "dap" }
				}
				local launch_gdb = {
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = "$${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				}
				dap.configurations.cpp = { launch_gdb }
				dap.configurations.c = { launch_gdb }

				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function ()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end
			'';
      plugins.dap = {
				enable = true;
				# adapters.executables.gdb = {
				# 	command = "gdb";
				# 	args = [ "-i" "dap" ];
				# };
				# configurations = let 
				# 	launch_gdb = {
				# 		name = "Launch";
				# 		request = "launch";
				# 		type = "gdb";
				# 		program = ''
				# 			function()
				# 			  vim.notify("haha")
				# 				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', 'file')
				# 			end
				# 		'';
				# 		cwd = "$${workspaceFolder}";
				# 	};
				# in {
				# 	c = [ launch_gdb ];
				# 	cpp = [ launch_gdb ];
				# };

				extensions = {
					dap-ui = {
						enable = true;
						forceBuffers = true;
						expandLines = true;
						layouts = [
							{
								elements = [
									{
										id = "scopes";
										size = 0.25;
									}
									{
										id = "breakpoints";
										size = 0.25;
									}
									{
										id = "stacks";
										size = 0.25;
									}
									{
										id = "watches";
										size = 0.25;
									}
								];
								position = "left";
								size = 40;
							}
							{
								elements = [
									{
										id = "repl";
										size = 0.5;
									}
									{
										id = "console";
										size = 0.5;
									}
								];
								position = "bottom";
								size = 10;
							}
						];
					}; # dap-ui
				}; # extensions
			}; # plugins.dap

			keymaps = lib.mkAfter [
        {
          action = "<cmd>lua require'dap'.toggle_breakpoint()<cr>";
          key = "<leader>b";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>lua require'dap'.continue()<cr>";
          key = "<F1>";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>lua require'dap'.step_into()<cr>";
          key = "<F2>";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>lua require'dap'.step_over()<cr>";
          key = "<F3>";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>lua require'dap'.step_out()<cr>";
          key = "<F4>";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>lua require'dap'.restart()<cr>";
          key = "<F12>";
          options.silent = true;
          mode = "n";
        }
        {
          action.__raw = ''
						function()
							require('dapui').eval(nil, { enter = true })
						end
					'';
          key = "<space>?";
          options.silent = true;
          mode = "n";
        }
			];
		};
	};
}
