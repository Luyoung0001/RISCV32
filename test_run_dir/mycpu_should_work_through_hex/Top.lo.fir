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
    node imm_i = bits(io_imem_inst, 31, 20) @[Core.scala 44:21]
    node _imm_i_sext_T = bits(imm_i, 11, 11) @[Core.scala 45:40]
    node _imm_i_sext_T_1 = bits(_imm_i_sext_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_i_sext_T_2 = mux(_imm_i_sext_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node imm_i_sext = cat(_imm_i_sext_T_2, imm_i) @[Cat.scala 31:58]
    node _imm_s_T = bits(io_imem_inst, 31, 25) @[Core.scala 47:25]
    node _imm_s_T_1 = bits(io_imem_inst, 11, 7) @[Core.scala 47:38]
    node imm_s = cat(_imm_s_T, _imm_s_T_1) @[Cat.scala 31:58]
    node _imm_s_sext_T = bits(imm_s, 11, 11) @[Core.scala 48:40]
    node _imm_s_sext_T_1 = bits(_imm_s_sext_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_s_sext_T_2 = mux(_imm_s_sext_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node imm_s_sext = cat(_imm_s_sext_T_2, imm_s) @[Cat.scala 31:58]
    node _csignals_T = and(io_imem_inst, UInt<15>("h707f")) @[Lookup.scala 31:38]
    node _csignals_T_1 = eq(UInt<14>("h2003"), _csignals_T) @[Lookup.scala 31:38]
    node _csignals_T_2 = and(io_imem_inst, UInt<15>("h707f")) @[Lookup.scala 31:38]
    node _csignals_T_3 = eq(UInt<14>("h2023"), _csignals_T_2) @[Lookup.scala 31:38]
    node _csignals_T_4 = and(io_imem_inst, UInt<32>("hfe00707f")) @[Lookup.scala 31:38]
    node _csignals_T_5 = eq(UInt<6>("h33"), _csignals_T_4) @[Lookup.scala 31:38]
    node _csignals_T_6 = and(io_imem_inst, UInt<15>("h707f")) @[Lookup.scala 31:38]
    node _csignals_T_7 = eq(UInt<5>("h13"), _csignals_T_6) @[Lookup.scala 31:38]
    node _csignals_T_8 = and(io_imem_inst, UInt<32>("hfe00707f")) @[Lookup.scala 31:38]
    node _csignals_T_9 = eq(UInt<31>("h40000033"), _csignals_T_8) @[Lookup.scala 31:38]
    node _csignals_T_10 = and(io_imem_inst, UInt<32>("hfe00707f")) @[Lookup.scala 31:38]
    node _csignals_T_11 = eq(UInt<15>("h7033"), _csignals_T_10) @[Lookup.scala 31:38]
    node _csignals_T_12 = and(io_imem_inst, UInt<32>("hfe00707f")) @[Lookup.scala 31:38]
    node _csignals_T_13 = eq(UInt<15>("h6033"), _csignals_T_12) @[Lookup.scala 31:38]
    node _csignals_T_14 = and(io_imem_inst, UInt<32>("hfe00707f")) @[Lookup.scala 31:38]
    node _csignals_T_15 = eq(UInt<15>("h4033"), _csignals_T_14) @[Lookup.scala 31:38]
    node _csignals_T_16 = and(io_imem_inst, UInt<15>("h707f")) @[Lookup.scala 31:38]
    node _csignals_T_17 = eq(UInt<15>("h7013"), _csignals_T_16) @[Lookup.scala 31:38]
    node _csignals_T_18 = and(io_imem_inst, UInt<15>("h707f")) @[Lookup.scala 31:38]
    node _csignals_T_19 = eq(UInt<15>("h6013"), _csignals_T_18) @[Lookup.scala 31:38]
    node _csignals_T_20 = and(io_imem_inst, UInt<15>("h707f")) @[Lookup.scala 31:38]
    node _csignals_T_21 = eq(UInt<15>("h4013"), _csignals_T_20) @[Lookup.scala 31:38]
    node _csignals_T_22 = mux(_csignals_T_21, UInt<5>("h5"), UInt<5>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_23 = mux(_csignals_T_19, UInt<5>("h4"), _csignals_T_22) @[Lookup.scala 34:39]
    node _csignals_T_24 = mux(_csignals_T_17, UInt<5>("h3"), _csignals_T_23) @[Lookup.scala 34:39]
    node _csignals_T_25 = mux(_csignals_T_15, UInt<5>("h5"), _csignals_T_24) @[Lookup.scala 34:39]
    node _csignals_T_26 = mux(_csignals_T_13, UInt<5>("h4"), _csignals_T_25) @[Lookup.scala 34:39]
    node _csignals_T_27 = mux(_csignals_T_11, UInt<5>("h3"), _csignals_T_26) @[Lookup.scala 34:39]
    node _csignals_T_28 = mux(_csignals_T_9, UInt<5>("h2"), _csignals_T_27) @[Lookup.scala 34:39]
    node _csignals_T_29 = mux(_csignals_T_7, UInt<5>("h1"), _csignals_T_28) @[Lookup.scala 34:39]
    node _csignals_T_30 = mux(_csignals_T_5, UInt<5>("h1"), _csignals_T_29) @[Lookup.scala 34:39]
    node _csignals_T_31 = mux(_csignals_T_3, UInt<5>("h1"), _csignals_T_30) @[Lookup.scala 34:39]
    node csignals_0 = mux(_csignals_T_1, UInt<5>("h1"), _csignals_T_31) @[Lookup.scala 34:39]
    node _csignals_T_32 = mux(_csignals_T_21, UInt<2>("h0"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_33 = mux(_csignals_T_19, UInt<2>("h0"), _csignals_T_32) @[Lookup.scala 34:39]
    node _csignals_T_34 = mux(_csignals_T_17, UInt<2>("h0"), _csignals_T_33) @[Lookup.scala 34:39]
    node _csignals_T_35 = mux(_csignals_T_15, UInt<2>("h0"), _csignals_T_34) @[Lookup.scala 34:39]
    node _csignals_T_36 = mux(_csignals_T_13, UInt<2>("h0"), _csignals_T_35) @[Lookup.scala 34:39]
    node _csignals_T_37 = mux(_csignals_T_11, UInt<2>("h0"), _csignals_T_36) @[Lookup.scala 34:39]
    node _csignals_T_38 = mux(_csignals_T_9, UInt<2>("h0"), _csignals_T_37) @[Lookup.scala 34:39]
    node _csignals_T_39 = mux(_csignals_T_7, UInt<2>("h0"), _csignals_T_38) @[Lookup.scala 34:39]
    node _csignals_T_40 = mux(_csignals_T_5, UInt<2>("h0"), _csignals_T_39) @[Lookup.scala 34:39]
    node _csignals_T_41 = mux(_csignals_T_3, UInt<2>("h0"), _csignals_T_40) @[Lookup.scala 34:39]
    node csignals_1 = mux(_csignals_T_1, UInt<2>("h0"), _csignals_T_41) @[Lookup.scala 34:39]
    node _csignals_T_42 = mux(_csignals_T_21, UInt<3>("h2"), UInt<3>("h1")) @[Lookup.scala 34:39]
    node _csignals_T_43 = mux(_csignals_T_19, UInt<3>("h2"), _csignals_T_42) @[Lookup.scala 34:39]
    node _csignals_T_44 = mux(_csignals_T_17, UInt<3>("h2"), _csignals_T_43) @[Lookup.scala 34:39]
    node _csignals_T_45 = mux(_csignals_T_15, UInt<3>("h1"), _csignals_T_44) @[Lookup.scala 34:39]
    node _csignals_T_46 = mux(_csignals_T_13, UInt<3>("h1"), _csignals_T_45) @[Lookup.scala 34:39]
    node _csignals_T_47 = mux(_csignals_T_11, UInt<3>("h1"), _csignals_T_46) @[Lookup.scala 34:39]
    node _csignals_T_48 = mux(_csignals_T_9, UInt<3>("h1"), _csignals_T_47) @[Lookup.scala 34:39]
    node _csignals_T_49 = mux(_csignals_T_7, UInt<3>("h2"), _csignals_T_48) @[Lookup.scala 34:39]
    node _csignals_T_50 = mux(_csignals_T_5, UInt<3>("h1"), _csignals_T_49) @[Lookup.scala 34:39]
    node _csignals_T_51 = mux(_csignals_T_3, UInt<3>("h3"), _csignals_T_50) @[Lookup.scala 34:39]
    node csignals_2 = mux(_csignals_T_1, UInt<3>("h2"), _csignals_T_51) @[Lookup.scala 34:39]
    node _csignals_T_52 = mux(_csignals_T_21, UInt<2>("h0"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_53 = mux(_csignals_T_19, UInt<2>("h0"), _csignals_T_52) @[Lookup.scala 34:39]
    node _csignals_T_54 = mux(_csignals_T_17, UInt<2>("h0"), _csignals_T_53) @[Lookup.scala 34:39]
    node _csignals_T_55 = mux(_csignals_T_15, UInt<2>("h0"), _csignals_T_54) @[Lookup.scala 34:39]
    node _csignals_T_56 = mux(_csignals_T_13, UInt<2>("h0"), _csignals_T_55) @[Lookup.scala 34:39]
    node _csignals_T_57 = mux(_csignals_T_11, UInt<2>("h0"), _csignals_T_56) @[Lookup.scala 34:39]
    node _csignals_T_58 = mux(_csignals_T_9, UInt<2>("h0"), _csignals_T_57) @[Lookup.scala 34:39]
    node _csignals_T_59 = mux(_csignals_T_7, UInt<2>("h0"), _csignals_T_58) @[Lookup.scala 34:39]
    node _csignals_T_60 = mux(_csignals_T_5, UInt<2>("h0"), _csignals_T_59) @[Lookup.scala 34:39]
    node _csignals_T_61 = mux(_csignals_T_3, UInt<2>("h1"), _csignals_T_60) @[Lookup.scala 34:39]
    node csignals_3 = mux(_csignals_T_1, UInt<2>("h0"), _csignals_T_61) @[Lookup.scala 34:39]
    node _csignals_T_62 = mux(_csignals_T_21, UInt<2>("h1"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_63 = mux(_csignals_T_19, UInt<2>("h1"), _csignals_T_62) @[Lookup.scala 34:39]
    node _csignals_T_64 = mux(_csignals_T_17, UInt<2>("h1"), _csignals_T_63) @[Lookup.scala 34:39]
    node _csignals_T_65 = mux(_csignals_T_15, UInt<2>("h1"), _csignals_T_64) @[Lookup.scala 34:39]
    node _csignals_T_66 = mux(_csignals_T_13, UInt<2>("h1"), _csignals_T_65) @[Lookup.scala 34:39]
    node _csignals_T_67 = mux(_csignals_T_11, UInt<2>("h1"), _csignals_T_66) @[Lookup.scala 34:39]
    node _csignals_T_68 = mux(_csignals_T_9, UInt<2>("h1"), _csignals_T_67) @[Lookup.scala 34:39]
    node _csignals_T_69 = mux(_csignals_T_7, UInt<2>("h1"), _csignals_T_68) @[Lookup.scala 34:39]
    node _csignals_T_70 = mux(_csignals_T_5, UInt<2>("h1"), _csignals_T_69) @[Lookup.scala 34:39]
    node _csignals_T_71 = mux(_csignals_T_3, UInt<2>("h0"), _csignals_T_70) @[Lookup.scala 34:39]
    node csignals_4 = mux(_csignals_T_1, UInt<2>("h1"), _csignals_T_71) @[Lookup.scala 34:39]
    node _csignals_T_72 = mux(_csignals_T_21, UInt<3>("h0"), UInt<3>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_73 = mux(_csignals_T_19, UInt<3>("h0"), _csignals_T_72) @[Lookup.scala 34:39]
    node _csignals_T_74 = mux(_csignals_T_17, UInt<3>("h0"), _csignals_T_73) @[Lookup.scala 34:39]
    node _csignals_T_75 = mux(_csignals_T_15, UInt<3>("h0"), _csignals_T_74) @[Lookup.scala 34:39]
    node _csignals_T_76 = mux(_csignals_T_13, UInt<3>("h0"), _csignals_T_75) @[Lookup.scala 34:39]
    node _csignals_T_77 = mux(_csignals_T_11, UInt<3>("h0"), _csignals_T_76) @[Lookup.scala 34:39]
    node _csignals_T_78 = mux(_csignals_T_9, UInt<3>("h0"), _csignals_T_77) @[Lookup.scala 34:39]
    node _csignals_T_79 = mux(_csignals_T_7, UInt<3>("h0"), _csignals_T_78) @[Lookup.scala 34:39]
    node _csignals_T_80 = mux(_csignals_T_5, UInt<3>("h0"), _csignals_T_79) @[Lookup.scala 34:39]
    node _csignals_T_81 = mux(_csignals_T_3, UInt<3>("h0"), _csignals_T_80) @[Lookup.scala 34:39]
    node csignals_5 = mux(_csignals_T_1, UInt<3>("h1"), _csignals_T_81) @[Lookup.scala 34:39]
    node _op1_data_T = eq(csignals_1, UInt<2>("h0")) @[Core.scala 76:18]
    node op1_data = mux(_op1_data_T, rs1_data, UInt<32>("h0")) @[Mux.scala 101:16]
    node _op2_data_T = eq(csignals_2, UInt<3>("h1")) @[Core.scala 80:18]
    node _op2_data_T_1 = eq(csignals_2, UInt<3>("h2")) @[Core.scala 81:18]
    node _op2_data_T_2 = eq(csignals_2, UInt<3>("h3")) @[Core.scala 82:18]
    node _op2_data_T_3 = mux(_op2_data_T_2, imm_s_sext, UInt<32>("h0")) @[Mux.scala 101:16]
    node _op2_data_T_4 = mux(_op2_data_T_1, imm_i_sext, _op2_data_T_3) @[Mux.scala 101:16]
    node op2_data = mux(_op2_data_T, rs2_addr, _op2_data_T_4) @[Mux.scala 101:16]
    node _alu_out_T = eq(csignals_0, UInt<5>("h1")) @[Core.scala 89:19]
    node _alu_out_T_1 = add(op1_data, op2_data) @[Core.scala 89:45]
    node _alu_out_T_2 = tail(_alu_out_T_1, 1) @[Core.scala 89:45]
    node _alu_out_T_3 = eq(csignals_0, UInt<5>("h2")) @[Core.scala 90:19]
    node _alu_out_T_4 = sub(op1_data, op2_data) @[Core.scala 90:45]
    node _alu_out_T_5 = tail(_alu_out_T_4, 1) @[Core.scala 90:45]
    node _alu_out_T_6 = eq(csignals_0, UInt<5>("h3")) @[Core.scala 91:19]
    node _alu_out_T_7 = and(op1_data, op2_data) @[Core.scala 91:45]
    node _alu_out_T_8 = eq(csignals_0, UInt<5>("h4")) @[Core.scala 92:19]
    node _alu_out_T_9 = or(op1_data, op2_data) @[Core.scala 92:44]
    node _alu_out_T_10 = eq(csignals_0, UInt<5>("h5")) @[Core.scala 93:19]
    node _alu_out_T_11 = xor(op1_data, op2_data) @[Core.scala 93:45]
    node _alu_out_T_12 = mux(_alu_out_T_10, _alu_out_T_11, UInt<32>("h0")) @[Mux.scala 101:16]
    node _alu_out_T_13 = mux(_alu_out_T_8, _alu_out_T_9, _alu_out_T_12) @[Mux.scala 101:16]
    node _alu_out_T_14 = mux(_alu_out_T_6, _alu_out_T_7, _alu_out_T_13) @[Mux.scala 101:16]
    node _alu_out_T_15 = mux(_alu_out_T_3, _alu_out_T_5, _alu_out_T_14) @[Mux.scala 101:16]
    node alu_out = mux(_alu_out_T, _alu_out_T_2, _alu_out_T_15) @[Mux.scala 101:16]
    node _wb_data_T = eq(csignals_5, UInt<3>("h1")) @[Core.scala 106:17]
    node wb_data = mux(_wb_data_T, io_dmem_rdata, alu_out) @[Mux.scala 101:16]
    node _T = eq(csignals_4, UInt<2>("h1")) @[Core.scala 109:17]
    node _GEN_0 = validif(_T, wb_addr) @[Core.scala 109:28 110:16]
    node _GEN_1 = validif(_T, clock) @[Core.scala 109:28 110:16]
    node _GEN_2 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[Core.scala 109:28 110:16 17:22]
    node _GEN_3 = validif(_T, UInt<1>("h1")) @[Core.scala 109:28 110:26]
    node _GEN_4 = validif(_T, wb_data) @[Core.scala 109:28 110:26]
    node _T_1 = asUInt(reset) @[Core.scala 115:11]
    node _T_2 = eq(_T_1, UInt<1>("h0")) @[Core.scala 115:11]
    node _T_3 = asUInt(reset) @[Core.scala 117:11]
    node _T_4 = eq(_T_3, UInt<1>("h0")) @[Core.scala 117:11]
    node _T_5 = asUInt(reset) @[Core.scala 118:11]
    node _T_6 = eq(_T_5, UInt<1>("h0")) @[Core.scala 118:11]
    node _T_7 = asUInt(reset) @[Core.scala 120:11]
    node _T_8 = eq(_T_7, UInt<1>("h0")) @[Core.scala 120:11]
    node _T_9 = asUInt(reset) @[Core.scala 121:11]
    node _T_10 = eq(_T_9, UInt<1>("h0")) @[Core.scala 121:11]
    node _T_11 = asUInt(reset) @[Core.scala 123:11]
    node _T_12 = eq(_T_11, UInt<1>("h0")) @[Core.scala 123:11]
    node _T_13 = asUInt(reset) @[Core.scala 124:11]
    node _T_14 = eq(_T_13, UInt<1>("h0")) @[Core.scala 124:11]
    node _T_15 = asUInt(reset) @[Core.scala 128:11]
    node _T_16 = eq(_T_15, UInt<1>("h0")) @[Core.scala 128:11]
    io_imem_addr <= pc_reg @[Core.scala 24:18]
    io_dmem_addr <= alu_out @[Core.scala 98:18]
    io_dmem_wen <= bits(csignals_3, 0, 0) @[Core.scala 100:17]
    io_dmem_wdata <= rs2_data @[Core.scala 101:19]
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
    printf(clock, and(and(UInt<1>("h1"), _T_2), UInt<1>("h1")), "pc_reg: 0x%x--->inst: 0x%x\n", pc_reg, io_imem_inst) : printf @[Core.scala 115:11]
    printf(clock, and(and(UInt<1>("h1"), _T_4), UInt<1>("h1")), "rs1_addr: 0x%x--->rs1_data: 0x%x\n", rs1_addr, rs1_data) : printf_1 @[Core.scala 117:11]
    printf(clock, and(and(UInt<1>("h1"), _T_6), UInt<1>("h1")), "rs2_addr: 0x%x--->rs2_data: 0x%x\n", rs2_addr, rs2_data) : printf_2 @[Core.scala 118:11]
    printf(clock, and(and(UInt<1>("h1"), _T_8), UInt<1>("h1")), "wb_addr: 0x%x--->wb_data: 0x%x\n", wb_addr, wb_data) : printf_3 @[Core.scala 120:11]
    printf(clock, and(and(UInt<1>("h1"), _T_10), UInt<1>("h1")), "dmem.addr: 0x%x\n", io_dmem_addr) : printf_4 @[Core.scala 121:11]
    printf(clock, and(and(UInt<1>("h1"), _T_12), UInt<1>("h1")), "dmem.wen: %d\n", io_dmem_wen) : printf_5 @[Core.scala 123:11]
    printf(clock, and(and(UInt<1>("h1"), _T_14), UInt<1>("h1")), "dmem.wdata: 0x%x\n", io_dmem_wdata) : printf_6 @[Core.scala 124:11]
    printf(clock, and(and(UInt<1>("h1"), _T_16), UInt<1>("h1")), "------------------------\n") : printf_7 @[Core.scala 128:11]

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
