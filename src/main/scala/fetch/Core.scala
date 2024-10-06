package fetch

import chisel3._
import chisel3.util._
import common.Consts._

class Core extends Module {
    val io = IO(new Bundle{
        // 生成输出端口 addr 和输入端口 inst
        val imem = Flipped(new ImemPortIO())
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

    // 测试
    // 打印 pc: inst
    printf(p"pc_reg: 0x${Hexadecimal(pc_reg)}--->inst: 0x${Hexadecimal(inst)}\n")
    // 打印寄存器地址和值
    printf(p"rs1_addr: 0x${Hexadecimal(rs1_addr)}--->rs1_data: 0x${Hexadecimal(rs1_data)}\n")
    printf(p"rs2_addr: 0x${Hexadecimal(rs2_addr)}--->rs2_data: 0x${Hexadecimal(rs2_data)}\n")
    printf(p"wb_addr: 0x${Hexadecimal(wb_addr)}\n")

    // 一次测试分割线
    printf("------------------------\n")


}