package common

import chisel3._
import chisel3.util._

object Consts {
    // 可以一直添加
    val WORD_LEN     = 32
    val START_ADDR   = 0.U(WORD_LEN.W)

    val ADDR_LEN = 5

    val EXE_FUNC_LEN = 5
    val ALU_X = 0.U(EXE_FUNC_LEN.W)
    val ALU_ADD = 1.U(EXE_FUNC_LEN.W)
    val ALU_SUB = 2.U(EXE_FUNC_LEN.W)
    val ALU_AND = 3.U(EXE_FUNC_LEN.W)
    val ALU_OR = 4.U(EXE_FUNC_LEN.W)
    val ALU_XOR = 5.U(EXE_FUNC_LEN.W)
    val ALU_SLL = 6.U(EXE_FUNC_LEN.W)
    val ALU_SRL = 7.U(EXE_FUNC_LEN.W)
    val ALU_SRA = 8.U(EXE_FUNC_LEN.W)
    val ALU_SLT = 9.U(EXE_FUNC_LEN.W)
    val ALU_SLTU = 10.U(EXE_FUNC_LEN.W)

    val BR_BEQ = 11.U(EXE_FUNC_LEN.W)
    val BR_BNE = 12.U(EXE_FUNC_LEN.W)
    val BR_BLT = 13.U(EXE_FUNC_LEN.W)
    val BR_BGE = 14.U(EXE_FUNC_LEN.W)
    val BR_BLTU = 15.U(EXE_FUNC_LEN.W)
    val BR_BGEU = 16.U(EXE_FUNC_LEN.W)

    val ALU_JALR = 17.U(EXE_FUNC_LEN.W)

    val OP1_LEN = 2
    val OP1_RS1 = 0.U(OP1_LEN.W)
    val OP1_PC = 1.U(OP1_LEN.W)
    val OP1_X = 2.U(OP1_LEN.W)
    val OP1_IMZ = 3.U(OP1_LEN.W)

    val OP2_LEN = 3
    val OP2_X = 0.U(OP2_LEN.W)
    val OP2_RS2 = 1.U(OP2_LEN.W)
    val OP2_IMI = 2.U(OP2_LEN.W)
    val OP2_IMS = 3.U(OP2_LEN.W)
    val OP2_IMJ = 4.U(OP2_LEN.W)
    val OP2_IMU = 5.U(OP2_LEN.W)

    val MEN_LEN = 2
    val MEN_X = 0.U(MEN_LEN.W)
    val MEN_S = 1.U(MEN_LEN.W)
    val MEN_V = 2.U(MEN_LEN.W)


    val REN_LEN = 2
    val REN_X = 0.U(REN_LEN.W)
    val REN_S = 1.U(REN_LEN.W)
    val REN_V = 2.U(REN_LEN.W)

    val WB_SEL_LEN = 3
    val WB_X = 0.U(WB_SEL_LEN.W)
    val WB_ALU = 0.U(WB_SEL_LEN.W)
    val WB_MEM = 1.U(WB_SEL_LEN.W)
    val WB_PC = 2.U(WB_SEL_LEN.W)
    val WB_CSR = 3.U(WB_SEL_LEN.W)
    val WB_MEM_V = 4.U(WB_SEL_LEN.W)
    val WB_ALU_V = 5.U(WB_SEL_LEN.W)
    val WB_VL = 6.U(WB_SEL_LEN.W)

    val MW_LEN = 3
    val MW_X = 0.U(MW_LEN.W)
    val MW_W = 1.U(MW_LEN.W)
    val MW_H = 2.U(MW_LEN.W)
    val MW_B = 3.U(MW_LEN.W)
    val MW_HU = 4.U(MW_LEN.W)
    val MW_BU = 5.U(MW_LEN.W)

}