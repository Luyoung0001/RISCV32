package fetch

import chisel3._
import chisel3.util._
import common.Consts._
import common.Instructions._

class Core extends Module {
    val io = IO(new Bundle{
        // 生成输出端口 addr 和输入端口 inst
        val imem = Flipped(new ImemPortIO())
        val dmem = Flipped(new DmemPortIO())
        // 输出
        val exit = Output(Bool())
    })
    // 生成 32 *32 个寄存器
    val regfile = Mem(32, UInt(WORD_LEN.W))

    // IF
    val pc_reg = RegInit(START_ADDR)
    pc_reg := pc_reg + 4.U(WORD_LEN.W)

    // 将 pc_reg 连接到 输出端口 addr
    io.imem.addr := pc_reg
    val inst = io.imem.inst

    // 检测 inst, 如果是停机信号，那就停止
    io.exit := (inst === 0x34333231.U(WORD_LEN.W))

    // 解析寄存器地址
    val rs1_addr = inst(19,15)
    val rs2_addr = inst(24,20)
    val wb_addr  = inst(11,7)

    // 访问寄存器
    val rs1_data = Mux(rs1_addr === 0.U(WORD_LEN.W), 0.U(WORD_LEN.W), regfile(rs1_addr))
    val rs2_data = Mux(rs2_addr === 0.U(WORD_LEN.W), 0.U(WORD_LEN.W), regfile(rs2_addr))





    // ID
    val imm_i = inst(31,20)
    val imm_i_sext = Cat(Fill(20, imm_i(11)), imm_i)

    val imm_s = Cat(inst(31,25), inst(11,7))
    val imm_s_sext = Cat(Fill(20, imm_s(11)), imm_s)




    val csignals = ListLookup(inst, List(ALU_X, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X),
        Array(
            LW ->List(ALU_ADD, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_MEM),
            SW ->List(ALU_ADD, OP1_RS1, OP2_IMS, MEN_S, REN_X, WB_X),

            ADD ->List(ALU_ADD, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
            ADDI ->List(ALU_ADD, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
            SUB ->List(ALU_SUB, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),

            AND ->List(ALU_AND, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
            OR ->List(ALU_OR, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
            XOR ->List(ALU_XOR, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
            ANDI ->List(ALU_AND, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
            ORI ->List(ALU_OR, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
            XORI ->List(ALU_XOR, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU)
        )
    )
    // 操作类型、第一操作数、第二操作数、是否写内存（数据类型）、是否写寄存器、回写数据类型
    val exe_func :: op1_sel :: op2_sel :: mem_wen :: rf_wen :: wb_sel :: Nil = csignals



    val op1_data = MuxCase(0.U(WORD_LEN.W), Seq(
        (op1_sel === OP1_RS1) -> rs1_data
    ))

    val op2_data = MuxCase(0.U(WORD_LEN.W), Seq(
        (op2_sel === OP2_RS2) -> rs2_addr,
        (op2_sel === OP2_IMI) -> imm_i_sext,
        (op2_sel === OP2_IMS) -> imm_s_sext

    ))


    // EX
    val alu_out = MuxCase(0.U(WORD_LEN.W), Seq(
        (exe_func === ALU_ADD) -> (op1_data + op2_data),
        (exe_func === ALU_SUB) -> (op1_data - op2_data),
        (exe_func === ALU_AND) -> (op1_data & op2_data),
        (exe_func === ALU_OR) -> (op1_data | op2_data),
        (exe_func === ALU_XOR) -> (op1_data ^ op2_data)
    ))

    // MEM
    // 无需仅仅在 LW 的时候才将 alu_out 连接到 数据地址线，这里一直连接
    io.dmem.addr := alu_out

    io.dmem.wen := mem_wen
    io.dmem.wdata := rs2_data


    // WB
    val wb_data = MuxCase(alu_out, Seq(
        (wb_sel === WB_MEM) -> io.dmem.rdata
    ))

    when(rf_wen === REN_S) {
        regfile(wb_addr) := wb_data
    }

    // 测试
    // 打印 pc: inst
    printf(p"pc_reg: 0x${Hexadecimal(pc_reg)}--->inst: 0x${Hexadecimal(inst)}\n")
    // 打印寄存器地址和值
    printf(p"rs1_addr: 0x${Hexadecimal(rs1_addr)}--->rs1_data: 0x${Hexadecimal(rs1_data)}\n")
    printf(p"rs2_addr: 0x${Hexadecimal(rs2_addr)}--->rs2_data: 0x${Hexadecimal(rs2_data)}\n")

    printf(p"wb_addr: 0x${Hexadecimal(wb_addr)}--->wb_data: 0x${Hexadecimal(wb_data)}\n")
    printf(p"dmem.addr: 0x${Hexadecimal(io.dmem.addr)}\n")

    printf(p"dmem.wen: ${io.dmem.wen}\n")
    printf(p"dmem.wdata: 0x${Hexadecimal(io.dmem.wdata)}\n")


    // 一次测试分割线
    printf("------------------------\n")


}