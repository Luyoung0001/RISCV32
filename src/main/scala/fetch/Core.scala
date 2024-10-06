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
    
    // 测试
    printf(p"pc_reg: 0x${Hexadecimal(pc_reg)}--->inst: 0x${Hexadecimal(inst)}\n")

}