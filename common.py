trace_help_string = "Dump a .vcd using verilator. **NOTE**: If you add the --trace flag, you must use it both with generate_harness.py and verilate.py. Also, you must either use --force-rebuild with verilate.py or be sure to remove any existing verilator binary, e.g. rm -r CGRAGenerator/verilator/generator_z_tb/build/*. One way to do this would be through a make clean rule"