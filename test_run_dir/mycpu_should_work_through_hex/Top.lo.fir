circuit Top :
  module Core :
    input clock : Clock
    input reset : UInt<1>
    output io_imem_addr : UInt<32>
    input io_imem_inst : UInt<32>
    output io_dmem_addr : UInt<32>
    input io_dmem_rdata : UInt<32>
    output io_exit : UInt<1>

    mem regfile : @[Core.scala 17:22]
      data-type => UInt<32>
      depth => 32
      read-latency => 0
      write-latency => 1
      reader => rs1_data_MPORT
      reader => rs2_data_MPORT
      writer => MPORT
      read-under-write => undefined
    reg pc_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc_reg) @[Core.scala 20:25]
    node _pc_reg_T = add(pc_reg, UInt<32>("h4")) @[Core.scala 21:22]
    node _pc_reg_T_1 = tail(_pc_reg_T, 1) @[Core.scala 21:22]
    node _io_exit_T = eq(io_imem_inst, UInt<32>("h34333231")) @[Core.scala 28:22]
    node rs1_addr = bits(io_imem_inst, 19, 15) @[Core.scala 31:24]
    node rs2_addr = bits(io_imem_inst, 24, 20) @[Core.scala 32:24]
    node wb_addr = bits(io_imem_inst, 11, 7) @[Core.scala 33:24]
    node _rs1_data_T = eq(rs1_addr, UInt<32>("h0")) @[Core.scala 36:33]
    node rs1_data = mux(_rs1_data_T, UInt<32>("h0"), regfile.rs1_data_MPORT.data) @[Core.scala 36:23]
    node _rs2_data_T = eq(rs2_addr, UInt<32>("h0")) @[Core.scala 37:33]
    node rs2_data = mux(_rs2_data_T, UInt<32>("h0"), regfile.rs2_data_MPORT.data) @[Core.scala 37:23]
    node imm_i = bits(io_imem_inst, 31, 20) @[Core.scala 41:21]
    node _imm_i_sext_T = bits(imm_i, 11, 11) @[Core.scala 42:40]
    node _imm_i_sext_T_1 = bits(_imm_i_sext_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_i_sext_T_2 = mux(_imm_i_sext_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node imm_i_sext = cat(_imm_i_sext_T_2, imm_i) @[Cat.scala 31:58]
    node _alu_out_T = and(io_imem_inst, UInt<15>("h707f")) @[Core.scala 46:15]
    node _alu_out_T_1 = eq(UInt<14>("h2003"), _alu_out_T) @[Core.scala 46:15]
    node _alu_out_T_2 = add(rs1_data, imm_i_sext) @[Core.scala 46:36]
    node _alu_out_T_3 = tail(_alu_out_T_2, 1) @[Core.scala 46:36]
    node alu_out = mux(_alu_out_T_1, _alu_out_T_3, UInt<32>("h0")) @[Mux.scala 101:16]
    node _T = and(io_imem_inst, UInt<15>("h707f")) @[Core.scala 54:15]
    node _T_1 = eq(UInt<14>("h2003"), _T) @[Core.scala 54:15]
    node _T_2 = bits(io_dmem_rdata, 4, 0) @[Core.scala 55:16]
    node _GEN_0 = validif(_T_1, _T_2) @[Core.scala 54:23 55:16]
    node _GEN_1 = validif(_T_1, clock) @[Core.scala 54:23 55:16]
    node _GEN_2 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[Core.scala 54:23 55:16 17:22]
    node _GEN_3 = validif(_T_1, UInt<1>("h1")) @[Core.scala 54:23 55:26]
    node _GEN_4 = validif(_T_1, io_dmem_rdata) @[Core.scala 54:23 55:26]
    node _T_3 = asUInt(reset) @[Core.scala 60:11]
    node _T_4 = eq(_T_3, UInt<1>("h0")) @[Core.scala 60:11]
    node _T_5 = asUInt(reset) @[Core.scala 62:11]
    node _T_6 = eq(_T_5, UInt<1>("h0")) @[Core.scala 62:11]
    node _T_7 = asUInt(reset) @[Core.scala 63:11]
    node _T_8 = eq(_T_7, UInt<1>("h0")) @[Core.scala 63:11]
    node _T_9 = asUInt(reset) @[Core.scala 65:11]
    node _T_10 = eq(_T_9, UInt<1>("h0")) @[Core.scala 65:11]
    node _T_11 = asUInt(reset) @[Core.scala 66:11]
    node _T_12 = eq(_T_11, UInt<1>("h0")) @[Core.scala 66:11]
    node _T_13 = asUInt(reset) @[Core.scala 70:11]
    node _T_14 = eq(_T_13, UInt<1>("h0")) @[Core.scala 70:11]
    io_imem_addr <= pc_reg @[Core.scala 24:18]
    io_dmem_addr <= alu_out @[Core.scala 50:18]
    io_exit <= _io_exit_T @[Core.scala 28:13]
    regfile.rs1_data_MPORT.addr <= rs1_addr @[Core.scala 36:78]
    regfile.rs1_data_MPORT.en <= UInt<1>("h1") @[Core.scala 36:78]
    regfile.rs1_data_MPORT.clk <= clock @[Core.scala 36:78]
    regfile.rs2_data_MPORT.addr <= rs2_addr @[Core.scala 37:78]
    regfile.rs2_data_MPORT.en <= UInt<1>("h1") @[Core.scala 37:78]
    regfile.rs2_data_MPORT.clk <= clock @[Core.scala 37:78]
    regfile.MPORT.addr <= _GEN_0
    regfile.MPORT.en <= _GEN_2
    regfile.MPORT.clk <= _GEN_1
    regfile.MPORT.data <= _GEN_4
    regfile.MPORT.mask <= _GEN_3
    pc_reg <= mux(reset, UInt<32>("h0"), _pc_reg_T_1) @[Core.scala 20:{25,25} 21:12]
    printf(clock, and(and(UInt<1>("h1"), _T_4), UInt<1>("h1")), "pc_reg: 0x%x--->inst: 0x%x\n", pc_reg, io_imem_inst) : printf @[Core.scala 60:11]
    printf(clock, and(and(UInt<1>("h1"), _T_6), UInt<1>("h1")), "rs1_addr: 0x%x--->rs1_data: 0x%x\n", rs1_addr, rs1_data) : printf_1 @[Core.scala 62:11]
    printf(clock, and(and(UInt<1>("h1"), _T_8), UInt<1>("h1")), "rs2_addr: 0x%x--->rs2_data: 0x%x\n", rs2_addr, rs2_data) : printf_2 @[Core.scala 63:11]
    printf(clock, and(and(UInt<1>("h1"), _T_10), UInt<1>("h1")), "wb_addr: 0x%x--->wb_data: 0x%x\n", wb_addr, io_dmem_rdata) : printf_3 @[Core.scala 65:11]
    printf(clock, and(and(UInt<1>("h1"), _T_12), UInt<1>("h1")), "dmem.addr: 0x%x\n", io_dmem_addr) : printf_4 @[Core.scala 66:11]
    printf(clock, and(and(UInt<1>("h1"), _T_14), UInt<1>("h1")), "------------------------\n") : printf_5 @[Core.scala 70:11]

  module Memory :
    input clock : Clock
    input reset : UInt<1>
    input io_imem_addr : UInt<32>
    output io_imem_inst : UInt<32>
    input io_dmem_addr : UInt<32>
    output io_dmem_rdata : UInt<32>

    mem mem : @[Memory.scala 25:18]
      data-type => UInt<8>
      depth => 16384
      read-latency => 0
      write-latency => 1
      reader => io_imem_inst_MPORT
      reader => io_imem_inst_MPORT_1
      reader => io_imem_inst_MPORT_2
      reader => io_imem_inst_MPORT_3
      reader => io_dmem_rdata_MPORT
      reader => io_dmem_rdata_MPORT_1
      reader => io_dmem_rdata_MPORT_2
      reader => io_dmem_rdata_MPORT_3
      read-under-write => undefined
    node _io_imem_inst_T = add(io_imem_addr, UInt<32>("h3")) @[Memory.scala 34:26]
    node _io_imem_inst_T_1 = tail(_io_imem_inst_T, 1) @[Memory.scala 34:26]
    node _io_imem_inst_T_2 = bits(_io_imem_inst_T_1, 13, 0) @[Memory.scala 34:12]
    node _io_imem_inst_T_3 = add(io_imem_addr, UInt<32>("h2")) @[Memory.scala 35:26]
    node _io_imem_inst_T_4 = tail(_io_imem_inst_T_3, 1) @[Memory.scala 35:26]
    node _io_imem_inst_T_5 = bits(_io_imem_inst_T_4, 13, 0) @[Memory.scala 35:12]
    node _io_imem_inst_T_6 = add(io_imem_addr, UInt<32>("h1")) @[Memory.scala 36:26]
    node _io_imem_inst_T_7 = tail(_io_imem_inst_T_6, 1) @[Memory.scala 36:26]
    node _io_imem_inst_T_8 = bits(_io_imem_inst_T_7, 13, 0) @[Memory.scala 36:12]
    node _io_imem_inst_T_9 = bits(io_imem_addr, 13, 0) @[Memory.scala 37:12]
    node io_imem_inst_lo = cat(mem.io_imem_inst_MPORT_2.data, mem.io_imem_inst_MPORT_3.data) @[Cat.scala 31:58]
    node io_imem_inst_hi = cat(mem.io_imem_inst_MPORT.data, mem.io_imem_inst_MPORT_1.data) @[Cat.scala 31:58]
    node _io_imem_inst_T_10 = cat(io_imem_inst_hi, io_imem_inst_lo) @[Cat.scala 31:58]
    node _io_dmem_rdata_T = add(io_dmem_addr, UInt<32>("h3")) @[Memory.scala 40:26]
    node _io_dmem_rdata_T_1 = tail(_io_dmem_rdata_T, 1) @[Memory.scala 40:26]
    node _io_dmem_rdata_T_2 = bits(_io_dmem_rdata_T_1, 13, 0) @[Memory.scala 40:12]
    node _io_dmem_rdata_T_3 = add(io_dmem_addr, UInt<32>("h2")) @[Memory.scala 41:26]
    node _io_dmem_rdata_T_4 = tail(_io_dmem_rdata_T_3, 1) @[Memory.scala 41:26]
    node _io_dmem_rdata_T_5 = bits(_io_dmem_rdata_T_4, 13, 0) @[Memory.scala 41:12]
    node _io_dmem_rdata_T_6 = add(io_dmem_addr, UInt<32>("h1")) @[Memory.scala 42:26]
    node _io_dmem_rdata_T_7 = tail(_io_dmem_rdata_T_6, 1) @[Memory.scala 42:26]
    node _io_dmem_rdata_T_8 = bits(_io_dmem_rdata_T_7, 13, 0) @[Memory.scala 42:12]
    node _io_dmem_rdata_T_9 = bits(io_dmem_addr, 13, 0) @[Memory.scala 43:12]
    node io_dmem_rdata_lo = cat(mem.io_dmem_rdata_MPORT_2.data, mem.io_dmem_rdata_MPORT_3.data) @[Cat.scala 31:58]
    node io_dmem_rdata_hi = cat(mem.io_dmem_rdata_MPORT.data, mem.io_dmem_rdata_MPORT_1.data) @[Cat.scala 31:58]
    node _io_dmem_rdata_T_10 = cat(io_dmem_rdata_hi, io_dmem_rdata_lo) @[Cat.scala 31:58]
    io_imem_inst <= _io_imem_inst_T_10 @[Memory.scala 33:18]
    io_dmem_rdata <= _io_dmem_rdata_T_10 @[Memory.scala 39:19]
    mem.io_imem_inst_MPORT.addr <= _io_imem_inst_T_2 @[Memory.scala 34:12]
    mem.io_imem_inst_MPORT.en <= UInt<1>("h1") @[Memory.scala 34:12]
    mem.io_imem_inst_MPORT.clk <= clock @[Memory.scala 34:12]
    mem.io_imem_inst_MPORT_1.addr <= _io_imem_inst_T_5 @[Memory.scala 35:12]
    mem.io_imem_inst_MPORT_1.en <= UInt<1>("h1") @[Memory.scala 35:12]
    mem.io_imem_inst_MPORT_1.clk <= clock @[Memory.scala 35:12]
    mem.io_imem_inst_MPORT_2.addr <= _io_imem_inst_T_8 @[Memory.scala 36:12]
    mem.io_imem_inst_MPORT_2.en <= UInt<1>("h1") @[Memory.scala 36:12]
    mem.io_imem_inst_MPORT_2.clk <= clock @[Memory.scala 36:12]
    mem.io_imem_inst_MPORT_3.addr <= _io_imem_inst_T_9 @[Memory.scala 37:12]
    mem.io_imem_inst_MPORT_3.en <= UInt<1>("h1") @[Memory.scala 37:12]
    mem.io_imem_inst_MPORT_3.clk <= clock @[Memory.scala 37:12]
    mem.io_dmem_rdata_MPORT.addr <= _io_dmem_rdata_T_2 @[Memory.scala 40:12]
    mem.io_dmem_rdata_MPORT.en <= UInt<1>("h1") @[Memory.scala 40:12]
    mem.io_dmem_rdata_MPORT.clk <= clock @[Memory.scala 40:12]
    mem.io_dmem_rdata_MPORT_1.addr <= _io_dmem_rdata_T_5 @[Memory.scala 41:12]
    mem.io_dmem_rdata_MPORT_1.en <= UInt<1>("h1") @[Memory.scala 41:12]
    mem.io_dmem_rdata_MPORT_1.clk <= clock @[Memory.scala 41:12]
    mem.io_dmem_rdata_MPORT_2.addr <= _io_dmem_rdata_T_8 @[Memory.scala 42:12]
    mem.io_dmem_rdata_MPORT_2.en <= UInt<1>("h1") @[Memory.scala 42:12]
    mem.io_dmem_rdata_MPORT_2.clk <= clock @[Memory.scala 42:12]
    mem.io_dmem_rdata_MPORT_3.addr <= _io_dmem_rdata_T_9 @[Memory.scala 43:12]
    mem.io_dmem_rdata_MPORT_3.en <= UInt<1>("h1") @[Memory.scala 43:12]
    mem.io_dmem_rdata_MPORT_3.clk <= clock @[Memory.scala 43:12]

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io_exit : UInt<1>

    inst core of Core @[Top.scala 12:25]
    inst memory of Memory @[Top.scala 13:25]
    io_exit <= core.io_exit @[Top.scala 18:13]
    core.clock <= clock
    core.reset <= reset
    core.io_imem_inst <= memory.io_imem_inst @[Top.scala 16:18]
    core.io_dmem_rdata <= memory.io_dmem_rdata @[Top.scala 17:18]
    memory.clock <= clock
    memory.reset <= reset
    memory.io_imem_addr <= core.io_imem_addr @[Top.scala 16:18]
    memory.io_dmem_addr <= core.io_dmem_addr @[Top.scala 17:18]
