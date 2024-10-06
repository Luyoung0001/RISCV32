circuit Top :
  module Core :
    input clock : Clock
    input reset : UInt<1>
    output io_imem_addr : UInt<32>
    input io_imem_inst : UInt<32>
    output io_exit : UInt<1>

    mem regfile : @[Core.scala 15:22]
      data-type => UInt<32>
      depth => 32
      read-latency => 0
      write-latency => 1
      read-under-write => undefined
    reg pc_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc_reg) @[Core.scala 18:25]
    node _pc_reg_T = add(pc_reg, UInt<32>("h4")) @[Core.scala 19:22]
    node _pc_reg_T_1 = tail(_pc_reg_T, 1) @[Core.scala 19:22]
    node _io_exit_T = eq(io_imem_inst, UInt<32>("h34333231")) @[Core.scala 26:22]
    node _T = asUInt(reset) @[Core.scala 28:11]
    node _T_1 = eq(_T, UInt<1>("h0")) @[Core.scala 28:11]
    io_imem_addr <= pc_reg @[Core.scala 22:18]
    io_exit <= _io_exit_T @[Core.scala 26:13]
    pc_reg <= mux(reset, UInt<32>("h0"), _pc_reg_T_1) @[Core.scala 18:{25,25} 19:12]
    printf(clock, and(and(UInt<1>("h1"), _T_1), UInt<1>("h1")), "pc_reg: 0x%x--->inst: 0x%x\n", pc_reg, io_imem_inst) : printf @[Core.scala 28:11]

  module Memory :
    input clock : Clock
    input reset : UInt<1>
    input io_imem_addr : UInt<32>
    output io_imem_inst : UInt<32>

    mem mem : @[Memory.scala 19:18]
      data-type => UInt<8>
      depth => 16384
      read-latency => 0
      write-latency => 1
      reader => io_imem_inst_MPORT
      reader => io_imem_inst_MPORT_1
      reader => io_imem_inst_MPORT_2
      reader => io_imem_inst_MPORT_3
      read-under-write => undefined
    node _io_imem_inst_T = add(io_imem_addr, UInt<32>("h3")) @[Memory.scala 27:26]
    node _io_imem_inst_T_1 = tail(_io_imem_inst_T, 1) @[Memory.scala 27:26]
    node _io_imem_inst_T_2 = bits(_io_imem_inst_T_1, 13, 0) @[Memory.scala 27:12]
    node _io_imem_inst_T_3 = add(io_imem_addr, UInt<32>("h2")) @[Memory.scala 28:26]
    node _io_imem_inst_T_4 = tail(_io_imem_inst_T_3, 1) @[Memory.scala 28:26]
    node _io_imem_inst_T_5 = bits(_io_imem_inst_T_4, 13, 0) @[Memory.scala 28:12]
    node _io_imem_inst_T_6 = add(io_imem_addr, UInt<32>("h1")) @[Memory.scala 29:26]
    node _io_imem_inst_T_7 = tail(_io_imem_inst_T_6, 1) @[Memory.scala 29:26]
    node _io_imem_inst_T_8 = bits(_io_imem_inst_T_7, 13, 0) @[Memory.scala 29:12]
    node _io_imem_inst_T_9 = bits(io_imem_addr, 13, 0) @[Memory.scala 30:12]
    node io_imem_inst_lo = cat(mem.io_imem_inst_MPORT_2.data, mem.io_imem_inst_MPORT_3.data) @[Cat.scala 31:58]
    node io_imem_inst_hi = cat(mem.io_imem_inst_MPORT.data, mem.io_imem_inst_MPORT_1.data) @[Cat.scala 31:58]
    node _io_imem_inst_T_10 = cat(io_imem_inst_hi, io_imem_inst_lo) @[Cat.scala 31:58]
    io_imem_inst <= _io_imem_inst_T_10 @[Memory.scala 26:18]
    mem.io_imem_inst_MPORT.addr <= _io_imem_inst_T_2 @[Memory.scala 27:12]
    mem.io_imem_inst_MPORT.en <= UInt<1>("h1") @[Memory.scala 27:12]
    mem.io_imem_inst_MPORT.clk <= clock @[Memory.scala 27:12]
    mem.io_imem_inst_MPORT_1.addr <= _io_imem_inst_T_5 @[Memory.scala 28:12]
    mem.io_imem_inst_MPORT_1.en <= UInt<1>("h1") @[Memory.scala 28:12]
    mem.io_imem_inst_MPORT_1.clk <= clock @[Memory.scala 28:12]
    mem.io_imem_inst_MPORT_2.addr <= _io_imem_inst_T_8 @[Memory.scala 29:12]
    mem.io_imem_inst_MPORT_2.en <= UInt<1>("h1") @[Memory.scala 29:12]
    mem.io_imem_inst_MPORT_2.clk <= clock @[Memory.scala 29:12]
    mem.io_imem_inst_MPORT_3.addr <= _io_imem_inst_T_9 @[Memory.scala 30:12]
    mem.io_imem_inst_MPORT_3.en <= UInt<1>("h1") @[Memory.scala 30:12]
    mem.io_imem_inst_MPORT_3.clk <= clock @[Memory.scala 30:12]

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io_exit : UInt<1>

    inst core of Core @[Top.scala 12:25]
    inst memory of Memory @[Top.scala 13:25]
    io_exit <= core.io_exit @[Top.scala 17:13]
    core.clock <= clock
    core.reset <= reset
    core.io_imem_inst <= memory.io_imem_inst @[Top.scala 16:18]
    memory.clock <= clock
    memory.reset <= reset
    memory.io_imem_addr <= core.io_imem_addr @[Top.scala 16:18]
