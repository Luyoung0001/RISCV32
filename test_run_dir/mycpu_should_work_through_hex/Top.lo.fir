circuit Top :
  module Core :
    input clock : Clock
    input reset : UInt<1>
    output io_imem_addr : UInt<32>
    input io_imem_inst : UInt<32>
    output io_dmem_addr : UInt<32>
    input io_dmem_rdata : UInt<32>
    output io_dmem_wen : UInt<1>
    output io_dmem_wdata : UInt<32>
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
    node _imm_s_T = bits(io_imem_inst, 31, 25) @[Core.scala 44:25]
    node _imm_s_T_1 = bits(io_imem_inst, 11, 7) @[Core.scala 44:38]
    node imm_s = cat(_imm_s_T, _imm_s_T_1) @[Cat.scala 31:58]
    node _imm_s_sext_T = bits(imm_s, 11, 11) @[Core.scala 45:40]
    node _imm_s_sext_T_1 = bits(_imm_s_sext_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_s_sext_T_2 = mux(_imm_s_sext_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node imm_s_sext = cat(_imm_s_sext_T_2, imm_s) @[Cat.scala 31:58]
    node _alu_out_T = and(io_imem_inst, UInt<15>("h707f")) @[Core.scala 49:15]
    node _alu_out_T_1 = eq(UInt<14>("h2003"), _alu_out_T) @[Core.scala 49:15]
    node _alu_out_T_2 = add(rs1_data, imm_i_sext) @[Core.scala 49:36]
    node _alu_out_T_3 = tail(_alu_out_T_2, 1) @[Core.scala 49:36]
    node _alu_out_T_4 = and(io_imem_inst, UInt<15>("h707f")) @[Core.scala 50:15]
    node _alu_out_T_5 = eq(UInt<14>("h2023"), _alu_out_T_4) @[Core.scala 50:15]
    node _alu_out_T_6 = add(rs1_data, imm_s_sext) @[Core.scala 50:36]
    node _alu_out_T_7 = tail(_alu_out_T_6, 1) @[Core.scala 50:36]
    node _alu_out_T_8 = mux(_alu_out_T_5, _alu_out_T_7, UInt<32>("h0")) @[Mux.scala 101:16]
    node alu_out = mux(_alu_out_T_1, _alu_out_T_3, _alu_out_T_8) @[Mux.scala 101:16]
    node _io_dmem_wen_T = and(io_imem_inst, UInt<15>("h707f")) @[Core.scala 57:26]
    node _io_dmem_wen_T_1 = eq(UInt<14>("h2023"), _io_dmem_wen_T) @[Core.scala 57:26]
    node _T = and(io_imem_inst, UInt<15>("h707f")) @[Core.scala 62:15]
    node _T_1 = eq(UInt<14>("h2003"), _T) @[Core.scala 62:15]
    node _GEN_0 = validif(_T_1, wb_addr) @[Core.scala 62:23 63:16]
    node _GEN_1 = validif(_T_1, clock) @[Core.scala 62:23 63:16]
    node _GEN_2 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[Core.scala 62:23 63:16 17:22]
    node _GEN_3 = validif(_T_1, UInt<1>("h1")) @[Core.scala 62:23 63:26]
    node _GEN_4 = validif(_T_1, io_dmem_rdata) @[Core.scala 62:23 63:26]
    node _T_2 = asUInt(reset) @[Core.scala 68:11]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[Core.scala 68:11]
    node _T_4 = asUInt(reset) @[Core.scala 70:11]
    node _T_5 = eq(_T_4, UInt<1>("h0")) @[Core.scala 70:11]
    node _T_6 = asUInt(reset) @[Core.scala 71:11]
    node _T_7 = eq(_T_6, UInt<1>("h0")) @[Core.scala 71:11]
    node _T_8 = asUInt(reset) @[Core.scala 73:11]
    node _T_9 = eq(_T_8, UInt<1>("h0")) @[Core.scala 73:11]
    node _T_10 = asUInt(reset) @[Core.scala 74:11]
    node _T_11 = eq(_T_10, UInt<1>("h0")) @[Core.scala 74:11]
    node _T_12 = asUInt(reset) @[Core.scala 76:11]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[Core.scala 76:11]
    node _T_14 = asUInt(reset) @[Core.scala 77:11]
    node _T_15 = eq(_T_14, UInt<1>("h0")) @[Core.scala 77:11]
    node _T_16 = asUInt(reset) @[Core.scala 81:11]
    node _T_17 = eq(_T_16, UInt<1>("h0")) @[Core.scala 81:11]
    io_imem_addr <= pc_reg @[Core.scala 24:18]
    io_dmem_addr <= alu_out @[Core.scala 55:18]
    io_dmem_wen <= _io_dmem_wen_T_1 @[Core.scala 57:17]
    io_dmem_wdata <= rs2_data @[Core.scala 58:19]
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
    printf(clock, and(and(UInt<1>("h1"), _T_3), UInt<1>("h1")), "pc_reg: 0x%x--->inst: 0x%x\n", pc_reg, io_imem_inst) : printf @[Core.scala 68:11]
    printf(clock, and(and(UInt<1>("h1"), _T_5), UInt<1>("h1")), "rs1_addr: 0x%x--->rs1_data: 0x%x\n", rs1_addr, rs1_data) : printf_1 @[Core.scala 70:11]
    printf(clock, and(and(UInt<1>("h1"), _T_7), UInt<1>("h1")), "rs2_addr: 0x%x--->rs2_data: 0x%x\n", rs2_addr, rs2_data) : printf_2 @[Core.scala 71:11]
    printf(clock, and(and(UInt<1>("h1"), _T_9), UInt<1>("h1")), "wb_addr: 0x%x--->wb_data: 0x%x\n", wb_addr, io_dmem_rdata) : printf_3 @[Core.scala 73:11]
    printf(clock, and(and(UInt<1>("h1"), _T_11), UInt<1>("h1")), "dmem.addr: 0x%x\n", io_dmem_addr) : printf_4 @[Core.scala 74:11]
    printf(clock, and(and(UInt<1>("h1"), _T_13), UInt<1>("h1")), "dmem.wen: %d\n", io_dmem_wen) : printf_5 @[Core.scala 76:11]
    printf(clock, and(and(UInt<1>("h1"), _T_15), UInt<1>("h1")), "dmem.wdata: 0x%x\n", io_dmem_wdata) : printf_6 @[Core.scala 77:11]
    printf(clock, and(and(UInt<1>("h1"), _T_17), UInt<1>("h1")), "------------------------\n") : printf_7 @[Core.scala 81:11]

  module Memory :
    input clock : Clock
    input reset : UInt<1>
    input io_imem_addr : UInt<32>
    output io_imem_inst : UInt<32>
    input io_dmem_addr : UInt<32>
    output io_dmem_rdata : UInt<32>
    input io_dmem_wen : UInt<1>
    input io_dmem_wdata : UInt<32>

    mem mem : @[Memory.scala 27:18]
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
      writer => MPORT
      writer => MPORT_1
      writer => MPORT_2
      writer => MPORT_3
      read-under-write => undefined
    node _io_imem_inst_T = add(io_imem_addr, UInt<32>("h3")) @[Memory.scala 37:26]
    node _io_imem_inst_T_1 = tail(_io_imem_inst_T, 1) @[Memory.scala 37:26]
    node _io_imem_inst_T_2 = bits(_io_imem_inst_T_1, 13, 0) @[Memory.scala 37:12]
    node _io_imem_inst_T_3 = add(io_imem_addr, UInt<32>("h2")) @[Memory.scala 38:26]
    node _io_imem_inst_T_4 = tail(_io_imem_inst_T_3, 1) @[Memory.scala 38:26]
    node _io_imem_inst_T_5 = bits(_io_imem_inst_T_4, 13, 0) @[Memory.scala 38:12]
    node _io_imem_inst_T_6 = add(io_imem_addr, UInt<32>("h1")) @[Memory.scala 39:26]
    node _io_imem_inst_T_7 = tail(_io_imem_inst_T_6, 1) @[Memory.scala 39:26]
    node _io_imem_inst_T_8 = bits(_io_imem_inst_T_7, 13, 0) @[Memory.scala 39:12]
    node _io_imem_inst_T_9 = bits(io_imem_addr, 13, 0) @[Memory.scala 40:12]
    node io_imem_inst_lo = cat(mem.io_imem_inst_MPORT_2.data, mem.io_imem_inst_MPORT_3.data) @[Cat.scala 31:58]
    node io_imem_inst_hi = cat(mem.io_imem_inst_MPORT.data, mem.io_imem_inst_MPORT_1.data) @[Cat.scala 31:58]
    node _io_imem_inst_T_10 = cat(io_imem_inst_hi, io_imem_inst_lo) @[Cat.scala 31:58]
    node _io_dmem_rdata_T = add(io_dmem_addr, UInt<32>("h3")) @[Memory.scala 43:26]
    node _io_dmem_rdata_T_1 = tail(_io_dmem_rdata_T, 1) @[Memory.scala 43:26]
    node _io_dmem_rdata_T_2 = bits(_io_dmem_rdata_T_1, 13, 0) @[Memory.scala 43:12]
    node _io_dmem_rdata_T_3 = add(io_dmem_addr, UInt<32>("h2")) @[Memory.scala 44:26]
    node _io_dmem_rdata_T_4 = tail(_io_dmem_rdata_T_3, 1) @[Memory.scala 44:26]
    node _io_dmem_rdata_T_5 = bits(_io_dmem_rdata_T_4, 13, 0) @[Memory.scala 44:12]
    node _io_dmem_rdata_T_6 = add(io_dmem_addr, UInt<32>("h1")) @[Memory.scala 45:26]
    node _io_dmem_rdata_T_7 = tail(_io_dmem_rdata_T_6, 1) @[Memory.scala 45:26]
    node _io_dmem_rdata_T_8 = bits(_io_dmem_rdata_T_7, 13, 0) @[Memory.scala 45:12]
    node _io_dmem_rdata_T_9 = bits(io_dmem_addr, 13, 0) @[Memory.scala 46:12]
    node io_dmem_rdata_lo = cat(mem.io_dmem_rdata_MPORT_2.data, mem.io_dmem_rdata_MPORT_3.data) @[Cat.scala 31:58]
    node io_dmem_rdata_hi = cat(mem.io_dmem_rdata_MPORT.data, mem.io_dmem_rdata_MPORT_1.data) @[Cat.scala 31:58]
    node _io_dmem_rdata_T_10 = cat(io_dmem_rdata_hi, io_dmem_rdata_lo) @[Cat.scala 31:58]
    node _T = bits(io_dmem_addr, 13, 0) @[Memory.scala 49:12]
    node _T_1 = bits(io_dmem_wdata, 7, 0) @[Memory.scala 49:43]
    node _T_2 = add(io_dmem_addr, UInt<1>("h1")) @[Memory.scala 50:26]
    node _T_3 = tail(_T_2, 1) @[Memory.scala 50:26]
    node _T_4 = bits(_T_3, 13, 0) @[Memory.scala 50:12]
    node _T_5 = bits(io_dmem_wdata, 15, 8) @[Memory.scala 50:49]
    node _T_6 = add(io_dmem_addr, UInt<2>("h2")) @[Memory.scala 51:26]
    node _T_7 = tail(_T_6, 1) @[Memory.scala 51:26]
    node _T_8 = bits(_T_7, 13, 0) @[Memory.scala 51:12]
    node _T_9 = bits(io_dmem_wdata, 23, 16) @[Memory.scala 51:49]
    node _T_10 = add(io_dmem_addr, UInt<2>("h3")) @[Memory.scala 52:26]
    node _T_11 = tail(_T_10, 1) @[Memory.scala 52:26]
    node _T_12 = bits(_T_11, 13, 0) @[Memory.scala 52:12]
    node _T_13 = bits(io_dmem_wdata, 31, 24) @[Memory.scala 52:49]
    node _GEN_0 = validif(io_dmem_wen, _T) @[Memory.scala 48:23 49:12]
    node _GEN_1 = validif(io_dmem_wen, clock) @[Memory.scala 48:23 49:12]
    node _GEN_2 = mux(io_dmem_wen, UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 48:23 49:12 27:18]
    node _GEN_3 = validif(io_dmem_wen, UInt<1>("h1")) @[Memory.scala 48:23 49:27]
    node _GEN_4 = validif(io_dmem_wen, _T_1) @[Memory.scala 48:23 49:27]
    node _GEN_5 = validif(io_dmem_wen, _T_4) @[Memory.scala 48:23 50:12]
    node _GEN_6 = validif(io_dmem_wen, _T_5) @[Memory.scala 48:23 50:33]
    node _GEN_7 = validif(io_dmem_wen, _T_8) @[Memory.scala 48:23 51:12]
    node _GEN_8 = validif(io_dmem_wen, _T_9) @[Memory.scala 48:23 51:33]
    node _GEN_9 = validif(io_dmem_wen, _T_12) @[Memory.scala 48:23 52:12]
    node _GEN_10 = validif(io_dmem_wen, _T_13) @[Memory.scala 48:23 52:33]
    io_imem_inst <= _io_imem_inst_T_10 @[Memory.scala 36:18]
    io_dmem_rdata <= _io_dmem_rdata_T_10 @[Memory.scala 42:19]
    mem.io_imem_inst_MPORT.addr <= _io_imem_inst_T_2 @[Memory.scala 37:12]
    mem.io_imem_inst_MPORT.en <= UInt<1>("h1") @[Memory.scala 37:12]
    mem.io_imem_inst_MPORT.clk <= clock @[Memory.scala 37:12]
    mem.io_imem_inst_MPORT_1.addr <= _io_imem_inst_T_5 @[Memory.scala 38:12]
    mem.io_imem_inst_MPORT_1.en <= UInt<1>("h1") @[Memory.scala 38:12]
    mem.io_imem_inst_MPORT_1.clk <= clock @[Memory.scala 38:12]
    mem.io_imem_inst_MPORT_2.addr <= _io_imem_inst_T_8 @[Memory.scala 39:12]
    mem.io_imem_inst_MPORT_2.en <= UInt<1>("h1") @[Memory.scala 39:12]
    mem.io_imem_inst_MPORT_2.clk <= clock @[Memory.scala 39:12]
    mem.io_imem_inst_MPORT_3.addr <= _io_imem_inst_T_9 @[Memory.scala 40:12]
    mem.io_imem_inst_MPORT_3.en <= UInt<1>("h1") @[Memory.scala 40:12]
    mem.io_imem_inst_MPORT_3.clk <= clock @[Memory.scala 40:12]
    mem.io_dmem_rdata_MPORT.addr <= _io_dmem_rdata_T_2 @[Memory.scala 43:12]
    mem.io_dmem_rdata_MPORT.en <= UInt<1>("h1") @[Memory.scala 43:12]
    mem.io_dmem_rdata_MPORT.clk <= clock @[Memory.scala 43:12]
    mem.io_dmem_rdata_MPORT_1.addr <= _io_dmem_rdata_T_5 @[Memory.scala 44:12]
    mem.io_dmem_rdata_MPORT_1.en <= UInt<1>("h1") @[Memory.scala 44:12]
    mem.io_dmem_rdata_MPORT_1.clk <= clock @[Memory.scala 44:12]
    mem.io_dmem_rdata_MPORT_2.addr <= _io_dmem_rdata_T_8 @[Memory.scala 45:12]
    mem.io_dmem_rdata_MPORT_2.en <= UInt<1>("h1") @[Memory.scala 45:12]
    mem.io_dmem_rdata_MPORT_2.clk <= clock @[Memory.scala 45:12]
    mem.io_dmem_rdata_MPORT_3.addr <= _io_dmem_rdata_T_9 @[Memory.scala 46:12]
    mem.io_dmem_rdata_MPORT_3.en <= UInt<1>("h1") @[Memory.scala 46:12]
    mem.io_dmem_rdata_MPORT_3.clk <= clock @[Memory.scala 46:12]
    mem.MPORT.addr <= _GEN_0
    mem.MPORT.en <= _GEN_2
    mem.MPORT.clk <= _GEN_1
    mem.MPORT.data <= _GEN_4
    mem.MPORT.mask <= _GEN_3
    mem.MPORT_1.addr <= _GEN_5
    mem.MPORT_1.en <= _GEN_2
    mem.MPORT_1.clk <= _GEN_1
    mem.MPORT_1.data <= _GEN_6
    mem.MPORT_1.mask <= _GEN_3
    mem.MPORT_2.addr <= _GEN_7
    mem.MPORT_2.en <= _GEN_2
    mem.MPORT_2.clk <= _GEN_1
    mem.MPORT_2.data <= _GEN_8
    mem.MPORT_2.mask <= _GEN_3
    mem.MPORT_3.addr <= _GEN_9
    mem.MPORT_3.en <= _GEN_2
    mem.MPORT_3.clk <= _GEN_1
    mem.MPORT_3.data <= _GEN_10
    mem.MPORT_3.mask <= _GEN_3

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
    memory.io_dmem_wen <= core.io_dmem_wen @[Top.scala 17:18]
    memory.io_dmem_wdata <= core.io_dmem_wdata @[Top.scala 17:18]
